//
//  MachineDetailView.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 02/12/22.
//

import UIKit

class MachineDetailView: UIViewController {
    
    let viewModel: IMachineDetailViewModel
    
    init(viewModel: IMachineDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MachineDetailView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Machine Data Detail"
        setupNavigation()
        viewModel.viewWillAppearing()
    }
    
    private func setupNavigation() {
        self.navigationController?.showBarIfNecessary()
        let editButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(didTapEditButton))
        navigationItem.rightBarButtonItem = editButton
    }
    
    private func setupEditButton(isEdit: Bool) {
        var editButton = UIBarButtonItem()
        if isEdit {
            editButton = UIBarButtonItem(image: UIImage(systemName: "x.circle"), style: .plain, target: self, action: #selector(didTapEditButton))
            editButton.tintColor = .red
        }else{
            editButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(didTapEditButton))
            editButton.tintColor = .blue
        }
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func didTapEditButton() {
        viewModel.didTapEditButton()
    }

}

extension MachineDetailView: IMachineDetailView {
    func reloadData() {
        machineIdLabel.text = viewModel.getId()
        machineNameLabel.text = viewModel.getName()
        machineTypeLabel.text = viewModel.getType()
        machineQRNumberLabel.text = viewModel.getQRCodeNumber()
        lastMaintenanceDateLabel.text = viewModel.getLastMaintenance().toString(with: "dd MMMM yyyy")
        
        machineNameTF.text = viewModel.getName()
        machineTypeTF.text = viewModel.getType()
        machineQRNumberTF.text = viewModel.getQRCodeNumber()
        lastMaintenanceDatePicker.date = viewModel.getLastMaintenance()
        
        machineIdLabel.isHidden = viewModel.isEdit()
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
    }
}
