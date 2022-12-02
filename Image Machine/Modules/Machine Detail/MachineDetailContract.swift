//
//  MachineDetailContract.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation
import UIKit

protocol IMachineDetailView: AnyObject {
    func showMessage(_ message: String, title: String, completion: (() -> Void)?)
    func reloadData()
}

protocol IMachineDetailViewModel {
    func setView(_ view: IMachineDetailView)
    func viewWillAppearing()
    func getId() -> String
    func getName() -> String
    func getType() -> String
    func getQRCodeNumber() -> String
    func getLastMaintenance() -> Date
    func isEdit() -> Bool
    func didTapEditButton()
}
