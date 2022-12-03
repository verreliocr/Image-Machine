//
//  MachineDataView.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import UIKit

class MachineDataView: UIViewController {
    
    let viewModel: IMachineDataViewModel
    
    init(viewModel: IMachineDataViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MachineDataView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var nameChevronIcon: UIImageView!
    @IBOutlet weak var typeChevronIcon: UIImageView!
    @IBOutlet weak var sortNameButton: UIButton!
    @IBOutlet weak var sortTypeButton: UIButton!
    @IBOutlet weak var machineDataTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Machine Data"
        setupNavigation()
        setupBarButton()
        viewModel.viewWillAppearing()
    }
    
    private func setupNavigation() {
        self.navigationController?.showBarIfNecessary()
    }
    
    private func setupBarButton() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func didTapAddButton() {
        viewModel.didTapAddButton()
    }
    
    private func setupAction() {
        sortNameButton.addAction { [unowned self] in
            self.viewModel.didTapSortByNameButton()
        }
        
        sortTypeButton.addAction { [unowned self] in
            self.viewModel.didTapSortByTypeButton()
        }
    }
    
    private func setupTableView() {
        machineDataTableView.rowHeight = UITableView.automaticDimension
        machineDataTableView.estimatedRowHeight = 200
        machineDataTableView.delegate = self
        machineDataTableView.dataSource = self
        machineDataTableView.register([MachineItemTableCell.self])
    }

}

extension MachineDataView: IMachineDataView {
    func reloadData() {
        emptyView.isHidden = viewModel.getNumberOfMachine() > 0
        
        nameChevronIcon.image = viewModel.getImageForSortByNameButton()
        typeChevronIcon.image = viewModel.getImageForSortByTypeButton()
        
        sortNameButton.titleLabel?.font = self.viewModel.getFontForSortByNameButton()
        sortTypeButton.titleLabel?.font = self.viewModel.getFontForSortByTypeButton()
        
        DispatchQueue.main.async { [unowned self] in
            self.machineDataTableView.reloadData()
        }
    }
}

extension MachineDataView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfMachine()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: MachineItemTableCell = tableView.dequeueReusableCell() {
            
            cell.bind(name: viewModel.getMachineName(for: indexPath.row),
                      type: viewModel.getMachineType(for: indexPath.row))
            
            cell.didTapDelete = { [weak self] in
                self?.viewModel.didTapDelete(for: indexPath.row)
            }
            
            return cell
        }
        return UITableViewCell()
    }
}

extension MachineDataView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectMachine(for: indexPath.row)
    }
}
