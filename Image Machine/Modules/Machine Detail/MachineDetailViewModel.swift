//
//  MachineDetailViewModel.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import Foundation
import UIKit

class MachineDetailViewModel: IMachineDetailViewModel, IModule {
    weak var view: IMachineDetailView?
    let model = MachineDetailModel()
    var router: IRouter
    
    init(router: IRouter) {
        self.router = router
    }
    
    func setView(_ view: IMachineDetailView) {
        self.view = view
    }
    
    func resolve(using params: [String : Any]) -> UIViewController {
        model.machineData = params["data"] as! MachineObject
        let view = MachineDetailView(viewModel: self)
        self.setView(view)
        
        return view
    }
    
    func viewWillAppearing() {
        view?.reloadData()
    }
    
    func getId() -> String {
        return model.machineData.id
    }
    
    func getName() -> String {
        return model.machineData.name
    }
    
    func getType() -> String {
        return model.machineData.type
    }
    
    func getQRCodeNumber() -> String {
        return "\(model.machineData.qrCode)"
    }
    
    func getLastMaintenance() -> Date {
        return model.machineData.lastMaintenance
    }
    
    func isEdit() -> Bool {
        return model.isEdit
    }
    
    func didTapEditButton() {
        model.isEdit = true
        view?.reloadData()
    }
}
