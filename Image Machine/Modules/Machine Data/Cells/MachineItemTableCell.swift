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
    @IBOutlet weak var actionButton: UIButton!
    
    var didTapDelete:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupAction()
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    private func setupAction() {
        actionButton.addAction { [weak self] in
            self?.didTapDelete?()
        }
    }
    
    func bind(name: String, type: String) {
        machineNameLabel.text = name
        machineTypeLabel.text = type
    }
    
}
