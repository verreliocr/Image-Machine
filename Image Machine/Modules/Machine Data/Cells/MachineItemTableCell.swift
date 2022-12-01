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
    
    var didTapEdit:(() -> Void)?
    var didTapDelete:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupMenu()
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    func setupMenu() {
        let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { [unowned self]  _ in
            self.didTapEdit?()
        }
        
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "minus")) { [unowned self] _ in
            self.didTapDelete?()
        }
        
        let menu = UIMenu(title: "Menu", children: [edit, delete])
        actionButton.menu = menu
        actionButton.showsMenuAsPrimaryAction = true
    }
    
    func bind(name: String, type: String) {
        machineNameLabel.text = name
        machineTypeLabel.text = type
    }
    
}
