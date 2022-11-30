//
//  MachineDataContract.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation

protocol IMachineDataView: AnyObject {
    func showMessage(_ message: String, title: String, completion: (() -> Void)?)
}

protocol ILoginViewModel {
    func setView(_ view: IMachineDataView)
}
