//
//  ScannerContract.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import Foundation

protocol IScannerView: AnyObject {
    func reloadView()
    func popView()
}

protocol ISCannerDelegate: AnyObject {
    func scannerDidScan(with id: String)
}

protocol IScannerViewModel {
    func setView(_ view: IScannerView)
    func viewLoaded()
    func scannerDidScan(with id: String)
}
