//
//  MachineDetailView.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 02/12/22.
//

import UIKit

class MachineDetailView: UIViewController {

    @IBOutlet weak var machineIdLabel: UILabel!
    @IBOutlet weak var machineNameLabel: UILabel!
    @IBOutlet weak var machineTypeLabel: UILabel!
    @IBOutlet weak var machineQRNumberLabel: UILabel!
    @IBOutlet weak var lastMaintenanceDateLabel: UILabel!
    
    @IBOutlet weak var machineIdTF: UITextField!
    @IBOutlet weak var machineNameTF: UITextField!
    @IBOutlet weak var machineTypeTF: UITextField!
    @IBOutlet weak var machineQRNumberTF: UITextField!
    @IBOutlet weak var lastMaintenanceDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
