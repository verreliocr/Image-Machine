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

    @IBOutlet weak var sortNameButton: UIButton!
    @IBOutlet weak var sortTypeButton: UIButton!
    @IBOutlet weak var machineDataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Machine Data"
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationController?.showBarIfNecessary()
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
        
    }
}

extension MachineDataView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfMachine()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: MachineItemTableCell = tableView.dequeueReusableCell() {
            
            cell.bind(name: viewModel.getMachineName(at: indexPath.row),
                      type: viewModel.getMachineType(at: indexPath.row))
            
            return cell
        }
        return UITableViewCell()
    }
}
