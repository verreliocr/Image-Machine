//
//  MachineDataModel.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation

enum SortType {
    case name
    case type
}

class MachineDataModel {
    var data: [MachineObject] = []
    var sortedBy: SortType = .name
    
    func dummies() {
        let machine0 = MachineObject(id: UUID().uuidString, name: "Refrigerator", type: "Kitchen", qrCode: 123, lastMaintenance: Date())
        let machine1 = MachineObject(id: UUID().uuidString, name: "TV", type: "Bed Room", qrCode: 123, lastMaintenance: Date())
        let machine2 = MachineObject(id: UUID().uuidString, name: "Microwave", type: "Kitchen", qrCode: 123, lastMaintenance: Date())
        let machine3 = MachineObject(id: UUID().uuidString, name: "TV", type: "Sitting Room", qrCode: 123, lastMaintenance: Date())
        let machine4 = MachineObject(id: UUID().uuidString, name: "Air Conditioner", type: "Bed Room", qrCode: 123, lastMaintenance: Date())
        let machine5 = MachineObject(id: UUID().uuidString, name: "Air Conditioner", type: "Sitting Room", qrCode: 123, lastMaintenance: Date())
        let machine6 = MachineObject(id: UUID().uuidString, name: "Coffe Maker", type: "Kitchen", qrCode: 123, lastMaintenance: Date())
        let machine7 = MachineObject(id: UUID().uuidString, name: "Rice Cooker", type: "Kitchen", qrCode: 123, lastMaintenance: Date())
        let machine8 = MachineObject(id: UUID().uuidString, name: "Computer", type: "Bed Room", qrCode: 123, lastMaintenance: Date())
        let machine9 = MachineObject(id: UUID().uuidString, name: "Stove", type: "Kitchen", qrCode: 123, lastMaintenance: Date())
        
        data = [machine0, machine1, machine2, machine3, machine4, machine5, machine6, machine7, machine8, machine9]
    }
}
