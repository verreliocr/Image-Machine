//
//  MachineDetailView.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 02/12/22.
//

import UIKit
import PhotosUI

class MachineDetailView: UIViewController {
    
    let viewModel: IMachineDetailViewModel
    
    init(viewModel: IMachineDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MachineDetailView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var machineIdStackView: UIStackView!
    
    @IBOutlet weak var machineIdLabel: UILabel!
    @IBOutlet weak var machineNameLabel: UILabel!
    @IBOutlet weak var machineTypeLabel: UILabel!
    @IBOutlet weak var machineQRNumberLabel: UILabel!
    @IBOutlet weak var lastMaintenanceDateLabel: UILabel!
    
    @IBOutlet weak var machineNameTF: UITextField!
    @IBOutlet weak var machineTypeTF: UITextField!
    @IBOutlet weak var machineQRNumberTF: UITextField!
    @IBOutlet weak var lastMaintenanceDatePicker: UIDatePicker!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupDatePicker()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Machine Data Detail"
        setupNavigation()
        viewModel.viewWillAppearing()
    }
    
    private func setupNavigation() {
        self.navigationController?.showBarIfNecessary()
    }
    
    private func setupEditButton(isEdit: Bool) {
        var editButton = UIBarButtonItem()
        if isEdit {
            editButton = UIBarButtonItem(image: UIImage(systemName: "x.circle"), style: .plain, target: self, action: #selector(didTapEditButton))
            editButton.tintColor = .red
        }else{
            editButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(didTapEditButton))
        }
        navigationItem.rightBarButtonItem = editButton
    }
    
    private func setupView() {
        backView.applyShadow()
    }
    
    @objc func didTapEditButton() {
        viewModel.didTapEditButton()
    }
    
    private func setupAction() {
        actionButton.addAction { [unowned self] in
            self.viewModel.didTapActionButton()
        }
        
        addImageButton.addAction { [unowned self] in
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 10
            configuration.filter = .images
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            
            self.present(picker, animated: true)
        }
    }
    
    @IBAction func machineNameDidChanged(_ sender: UITextField) {
        viewModel.setName(sender.text ?? "")
    }
    
    @IBAction func machineTypeDidChanged(_ sender: UITextField) {
        viewModel.setType(sender.text ?? "")
    }
    
    @IBAction func machineQRCodeDidChanged(_ sender: UITextField) {
        viewModel.setQRCodeNumber(sender.text ?? "")
    }
    
    private func setupDatePicker() {
        lastMaintenanceDatePicker.addTarget(self, action: #selector(selectDate), for: .valueChanged)
    }
    
    @objc func selectDate(sender: UIDatePicker) {
        viewModel.setLastMaintenance(sender.date)
    }
    
    private func setupCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register([ImageCollectionCell.self])
    }

}

extension MachineDetailView: IMachineDetailView {
    func reloadData() {
        DispatchQueue.main.async { [unowned self] in
            machineIdStackView.isHidden = viewModel.isAdd()
            
            machineIdLabel.text = viewModel.getId()
            machineNameLabel.text = viewModel.getName()
            machineTypeLabel.text = viewModel.getType()
            machineQRNumberLabel.text = viewModel.getQRCodeNumber()
            lastMaintenanceDateLabel.text = viewModel.getLastMaintenance().toString(with: "dd MMMM yyyy")
            
            machineNameTF.text = viewModel.getName()
            machineTypeTF.text = viewModel.getType()
            machineQRNumberTF.text = viewModel.getQRCodeNumber()
            lastMaintenanceDatePicker.date = viewModel.getLastMaintenance()
            
            machineNameLabel.isHidden = viewModel.isEdit()
            machineTypeLabel.isHidden = viewModel.isEdit()
            machineQRNumberLabel.isHidden = viewModel.isEdit()
            lastMaintenanceDateLabel.isHidden = viewModel.isEdit()
            
            machineNameTF.isHidden = !viewModel.isEdit()
            machineTypeTF.isHidden = !viewModel.isEdit()
            machineQRNumberTF.isHidden = !viewModel.isEdit()
            lastMaintenanceDatePicker.isHidden = !viewModel.isEdit()
            
            if !viewModel.isAdd() {
                setupEditButton(isEdit: viewModel.isEdit())
            }
            
            actionButton.setTitle(viewModel.getTextForActionButton(), for: .normal)
            actionButton.isHidden = !viewModel.isEdit()
            
            self.imageCollectionView.reloadData()
        }
    }
}

extension MachineDetailView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: ImageCollectionCell = collectionView.dequeueReusableCell(indexPath) {
            
            cell.bind(image: viewModel.getImage(for: indexPath.item))
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension MachineDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MachineDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 48) / 3
        return CGSize(width: width, height: width)
    }
}

extension MachineDetailView: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let dispatchGroup = DispatchGroup()
        
        var images: [UIImage] = []
        
        for result in results {
            dispatchGroup.enter()
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] item, error in
                    if let image = item as? UIImage {
                        images.append(image)
                        if result == results.last {
                            self?.viewModel.didFinishPickingImage(with: images)
                        }
                    }
                }
            }
        }
    }
}
