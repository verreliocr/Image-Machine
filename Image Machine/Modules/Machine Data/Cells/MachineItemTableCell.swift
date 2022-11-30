//
//  MachineItemTableCell.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import UIKit

class MachineItemTableCell: UITableViewCell {

    @IBOutlet weak var machineNameLabel: UILabel!
    @IBOutlet weak var machineTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    func bind(name: String, type: String) {
        machineNameLabel.text = name
        machineTypeLabel.text = type
    }
    
}
