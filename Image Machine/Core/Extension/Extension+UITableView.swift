//
//  Extension+UITableView.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation
import UIKit

extension UITableView {
    func register(_ cells: [UITableViewCell.Type]) {
        for cell in cells {
            register(cell.defaultNib, forCellReuseIdentifier: cell.defaultIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        return dequeueReusableCell(withIdentifier: T.defaultIdentifier) as? T
    }
}
