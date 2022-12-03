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
        if let machines = try? Disk.retrieve("machine.json", from: .applicationSupport, as: [MachineObject].self) {
            return machines
        }
        return []
    }
    
    static func saveImage(_ data: [UIImage], folderName: String) {
        try? Disk.save(data, to: .documents, as: "\(folderName)/")
    }
    
    static func retrievedImage(folderName: String) -> [UIImage] {
        if let images = try? Disk.retrieve("\(folderName)/", from: .documents, as: [UIImage].self) {
            return images
        }
        return []
    }
}
