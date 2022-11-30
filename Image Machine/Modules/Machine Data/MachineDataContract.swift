//
//  MachineDataContract.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation

protocol IMachineDataView: AnyObject {
    func showMessage(_ message: String, title: String, completion: (() -> Void)?)
    func reloadData()
}

protocol IMachineDataViewModel {
    func setView(_ view: IMachineDataView)
    func getNumberOfMaching() -> Int
    func getMachineName(at row: Int) -> String
    func getMachineType(at row: Int) -> String
    func getSortedBy() -> String
    func getSortedType() -> String
}
