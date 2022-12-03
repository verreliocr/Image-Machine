//
//  ScannerView.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import UIKit
import AVFoundation
import SnapKit

class ScannerView: UIViewController {
    
    let viewModel: IScannerViewModel
    
    init(viewModel: IScannerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var captureSession = AVCaptureSession()
    
    private (set) var backButton: UIButton! {
        didSet {
            view.addSubview(backButton)
            backButton.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 24, height: 24))
                make.top.equalToSuperview().offset(48)
                make.left.equalToSuperview().offset(16)
            }
        }
    }
    
    private (set) var boundingView: CornerRect! {
        didSet {
            view.addSubview(boundingView)
            
            boundingView.snp.makeConstraints { make in
              make.size.equalTo(CGSize(width: 338, height: 338))
              make.center.equalToSuperview()
            }
        }
    }
    
    private (set) var capturedView: UIView! {
        didSet {
            view.addSubview(capturedView)
            
            capturedView.layer.borderColor = UIColor.tintColor.cgColor
            capturedView.layer.borderWidth = 1
        }
    }
    
    private (set) var titleLabel: UILabel! {
        didSet {
            view.addSubview(titleLabel)
            
            titleLabel.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 120, height: 24))
                make.top.equalToSuperview().offset(48)
                make.centerX.equalToSuperview()
            }
        }
    }

    private (set) var notesLabel: UILabel! {
        didSet {
            view.addSubview(notesLabel)
            
            notesLabel.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 240, height: 40))
                make.top.equalTo(boundingView.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
            }
        }
    }
    
    private (set) var previewLayer: AVCaptureVideoPreviewLayer! {
        didSet {
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.layer.bounds
            previewLayer.borderColor = UIColor.tintColor.cgColor
            
            view.layer.addSublayer(previewLayer!)
        }
    }
    
    private func layerWithHole() {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), cornerRadius: 0)
        let circlePath = UIBezierPath(roundedRect: CGRect(x: UIScreen.main.bounds.width / 2 - 164,
                                                          y: UIScreen.main.bounds.height / 2 - 164,
                                                          width: 328, height: 328), cornerRadius: 0)
        path.append(circlePath)
        path.usesEvenOddFillRule = true

        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.5
        view.layer.addSublayer(fillLayer)
    }
    
    private func checkCameraPermission(completion: @escaping () -> Void) {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            completion()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    completion()
                } else {
                    self.popView()
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideBarIfNecessary()
    }
    
    private func setupView() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        
        guard self.captureSession.canAddInput(input) else {
            return
        }
        
        self.captureSession.addInput(input)
        
        let output = AVCaptureMetadataOutput()
        
        guard self.captureSession.canAddOutput(output) else {
            return
        }
        
        self.captureSession.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        
        self.layerWithHole()
        
        self.boundingView = CornerRect()
        self.boundingView.color = UIColor.tintColor
        self.boundingView.thickness = 5
        self.boundingView.backgroundColor = .clear
        
        self.capturedView = UIView()
        
        self.backButton = UIButton()
        self.backButton.applyShadow()
        self.backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        self.backButton.selfCornerRadius = true
        
        self.backButton.addAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Scan QR Code"
        self.titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.titleLabel.textColor = .white
        self.titleLabel.backgroundColor = .clear
        
        self.notesLabel = UILabel()
        self.notesLabel.text = "Place the QR code inside area"
        self.notesLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.notesLabel.textColor = .white
        self.notesLabel.backgroundColor = .clear
    }

}

extension ScannerView: IScannerView {
    func reloadView() {
        capturedView.frame = CGRect.zero
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            captureSession.startRunning()
        }
    }
}

extension ScannerView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {

        guard metadataObjects.count > 0 else {
            return
        }

        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
          metadataObject.type == .qr else {
            return
        }
        
        guard let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObject) else {
            return
        }
        
        if let value = metadataObject.stringValue {
            viewModel.scannerDidScan(with: value)
        }
        
        captureSession.stopRunning()
        capturedView.frame = barCodeObject.bounds
        
    }
}
