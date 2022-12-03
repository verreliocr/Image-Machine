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
        model.isAdd = params["isAdd"] as! Bool
        if !model.isAdd {
            model.machineData = params["data"] as! MachineObject
        }
        let view = MachineDetailView(viewModel: self)
        self.setView(view)
        
        return view
    }
    
    func viewWillAppearing() {
        if isAdd() {
            model.machineData.id = UUID().uuidString
        }
        model.images = DiskHelper.retrievedImage(folderName: model.machineData.id)
        
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
        return model.machineData.qrCode.description
    }
    
    func getLastMaintenance() -> Date {
        return model.machineData.lastMaintenance
    }
    
    func getTextForActionButton() -> String {
        if isAdd() {
            return "Add Machine"
        }else{
            return "Edit Machine"
        }
    }
    
    func isAdd() -> Bool {
        return model.isAdd
    }
    
    func isEdit() -> Bool {
        if isAdd() {
            return true
        }
        return model.isEdit
    }
    
    func setName(_ value: String) {
        model.machineData.name = value
    }
    
    func setType(_ value: String) {
        model.machineData.type = value
    }
    
    func setQRCodeNumber(_ value: String) {
        model.machineData.qrCode = value.toInt()
    }
    
    func setLastMaintenance(_ value: Date) {
        model.machineData.lastMaintenance = value
    }
    
    func getNumberOfImages() -> Int {
        return model.images.count
    }
    
    func getImage(for item: Int) -> UIImage {
        return model.images[item]
    }
    
    func didTapEditButton() {
        model.isEdit = !model.isEdit
        view?.reloadData()
    }
    
    private func addAction() {
        var machineData = DiskHelper.retrieveMachineData()
        machineData.append(model.machineData)
        DiskHelper.saveMachineData(machineData)
        view?.showMessage("Machine's successfully added.", title: "Info", completion: { [weak self] in
            self?.view?.popView()
        })
    }
    
    private func editAction() {
        var machineData = DiskHelper.retrieveMachineData()
        
        machineData.removeAll(where: { $0.id == model.machineData.id })
        machineData.append(model.machineData)
        
        DiskHelper.saveMachineData(machineData)
        
        view?.showMessage("machine's successfully updated.", title: "Info", completion: { [weak self] in
            self?.model.isEdit = false
            self?.view?.reloadData()
        })
    }
    
    func didTapActionButton() {
        if isAdd() {
            addAction()
        }else{
            editAction()
        }
    }
    
    func didFinishPickingImage(with images: [UIImage]) {
        model.images.append(contentsOf: images)
        DiskHelper.saveImage(model.images, folderName: model.machineData.id)
        view?.reloadData()
    }
}
