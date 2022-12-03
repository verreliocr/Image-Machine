//
//  DiskHelper.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import Foundation
import Disk

struct DiskHelper {
    static func saveMachineData(_ data: [MachineObject]) {
        try? Disk.save(data, to: .applicationSupport, as: "machine.json")
    }
    
    static func retrieveMachineData() -> [MachineObject] {
        if let token = try? Disk.retrieve("machine.json", from: .applicationSupport, as: [MachineObject].self) {
            return token
        }
        return []
    }
}
