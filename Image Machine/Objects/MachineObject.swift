//
//  MachineObject.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation

struct MachineObject {
    var id: String
    var name: String
    var type: String
    var qrCode: Int
    var lastMaintenance: Date
    
    func defaultValue() -> MachineObject {
        return MachineObject(id: "", name: "", type: "", qrCode: 0, lastMaintenance: Date())
    }
}
