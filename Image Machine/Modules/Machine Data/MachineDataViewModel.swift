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
    
    func viewWillAppearing() {
        model.data = DiskHelper.retrieveMachineData()
        view?.reloadData()
    }
    
    func getSortedBy() -> SortType {
        return model.sortedBy
    }
    
    func getImageForSortByNameButton() -> UIImage? {
        switch getSortedBy() {
        case .name:
            return UIImage(systemName: "chevron.down.square.fill")
        case .type:
            return UIImage(named: "")
        }
    }
    
    func getImageForSortByTypeButton() -> UIImage? {
        switch getSortedBy() {
        case .name:
            return UIImage(named: "")
        case .type:
            return UIImage(systemName: "chevron.down.square.fill")
        }
    }
    
    func getFontForSortByNameButton() -> UIFont {
        switch getSortedBy() {
        case .name:
            return UIFont.systemFont(ofSize: 20, weight: .medium)
        case .type:
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    func getFontForSortByTypeButton() -> UIFont {
        switch getSortedBy() {
        case .name:
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        case .type:
            return UIFont.systemFont(ofSize: 20, weight: .medium)
        }
    }
    
    func getNumberOfMachine() -> Int {
        return model.data.count
    }
    
    func getMachineData(for row: Int) -> MachineObject {
        switch getSortedBy() {
        case .name:
            let sorted = model.data.sorted(by: { ($0.name, $0.type) < ($1.name, $1.type) })
            return sorted[row]
        case .type:
            let sorted = model.data.sorted(by: { ($0.type, $0.name) < ($1.type, $1.name) })
            return sorted[row]
        }
    }
    
    func getMachineName(for row: Int) -> String {
        return getMachineData(for: row).name
    }
    
    func getMachineType(for row: Int) -> String {
        return getMachineData(for: row).type
    }
    
    func didSelectMachine(for row: Int) {
        let params: [String: Any] = ["isAdd": false,
                                     "data": getMachineData(for: row)]
        
        router.push(module: .machineDetail, using: params)
    }
    
    func didTapDelete(for row: Int) {
        let selectedMachine = getMachineData(for: row)
        
        model.data.removeAll(where: { $0.id == selectedMachine.id })
        DiskHelper.saveMachineData(model.data)
        view?.reloadData()
    }
    
    func didTapSortByNameButton() {
        model.sortedBy = .name
        view?.reloadData()
    }
    
    func didTapSortByTypeButton() {
        model.sortedBy = .type
        view?.reloadData()
    }
    
    func didTapAddButton() {
        let params: [String: Any] = ["isAdd": true]
        
        router.push(module: .machineDetail, using: params)
    }
}
