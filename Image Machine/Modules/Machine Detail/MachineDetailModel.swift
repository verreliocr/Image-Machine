//
//  MachineDetailModel.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation
import UIKit

class MachineDetailModel {
    var machineData: MachineObject = MachineObject(id: "", name: "", type: "", qrCode: 0, lastMaintenance: Date())
    var isEdit: Bool = false
    var isAdd: Bool = false
    var images: [UIImage] = []
}
