//
//  MachineObject.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation

struct MachineObject: Codable {
    var id: String
    var name: String
    var type: String
    var qrCode: Int
    var lastMaintenance: Date
}
