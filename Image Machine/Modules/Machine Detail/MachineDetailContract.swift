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
    func popView()
}

protocol IMachineDetailViewModel {
    func setView(_ view: IMachineDetailView)
    func viewWillAppearing()
    
    func getId() -> String
    func getName() -> String
    func getType() -> String
    func getQRCodeNumber() -> String
    func getLastMaintenance() -> Date
    
    func getTextForActionButton() -> String
    
    func isAdd() -> Bool
    func isEdit() -> Bool
    
    func setName(_ value: String)
    func setType(_ value: String)
    func setQRCodeNumber(_ value: String)
    func setLastMaintenance(_ value: Date)
    
    func getNumberOfImages() -> Int
    func getImage(for item: Int) -> UIImage
    
    func didTapEditButton()
    func didTapActionButton()
    
    func didFinishPickingImage(with images: [UIImage])
}
