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

}

extension MachineDataView: IMachineDataView {
    func reloadData() {
        
    }
}
