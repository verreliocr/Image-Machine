//
//  Extension+UICollectionViewCell.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var defaultIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: defaultIdentifier, bundle: nil)
    }
}
