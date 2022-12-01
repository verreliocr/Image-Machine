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
    @IBOutlet weak var testbutton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupMenu()
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    func setupMenu() {
        
        let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { _ in
            print("Edit")
        }
        
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "minus")) { _ in
            print("Delete")
        }
        
        let menu = UIMenu(title: "Menu", children: [edit, delete])
        testbutton.menu = menu
        testbutton.showsMenuAsPrimaryAction = true
    }
    
    func bind(name: String, type: String) {
        machineNameLabel.text = name
        machineTypeLabel.text = type
    }
    
}
