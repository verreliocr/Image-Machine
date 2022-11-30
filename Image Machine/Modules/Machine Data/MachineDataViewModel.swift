//
//  MachineDataViewModel.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation
import UIKit

class MachineDataViewModel: IMachineDataViewModel, IModule {
    
    weak var view: IMachineDataView?
    let model = MachineDataModel()
    var router: IRouter
    
    init(router: IRouter) {
        self.router = router
    }
    
    func setView(_ view: IMachineDataView) {
        self.view = view
    }
    
    func resolve(using params: [String : Any]) -> UIViewController {
        let view = MachineDataView(viewModel: self)
        self.setView(view)
        
        return view
    }
    
    func getNumberOfMachine() -> Int {
        return model.data.count
    }
    
    func getMachineName(at row: Int) -> String {
        return model.data[row].name
    }
    
    func getMachineType(at row: Int) -> String {
        return model.data[row].type
    }
    
    func getSortedBy() -> String {
        return model.sortedBy
    }
    
    func getSortedType() -> String {
        return model.sortedType
    }
}
