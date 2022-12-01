//
//  MachineDataContract.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation
import UIKit

protocol IMachineDataView: AnyObject {
    func showMessage(_ message: String, title: String, completion: (() -> Void)?)
    func reloadData()
}

protocol IMachineDataViewModel {
    func setView(_ view: IMachineDataView)
    func viewWillAppearing()
    
    func getSortedBy() -> SortType
    
    func getImageForSortByNameButton() -> UIImage?
    func getImageForSortByTypeButton() -> UIImage?
    func getFontForSortByNameButton() -> UIFont
    func getFontForSortByTypeButton() -> UIFont
    
    func getNumberOfMachine() -> Int
    func getMachineName(for row: Int) -> String
    func getMachineType(for row: Int) -> String
    func didTapDelete(for row: Int)
    
    func didTapSortByNameButton()
    func didTapSortByTypeButton()
}
