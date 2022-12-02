//
//  FeatureModule.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation
import UIKit

enum FeatureModule {
    case machineData
    case machineDetail

    func create(using router: IRouter) -> IModule {
        switch self {
        case .machineData:
            return MachineDataViewModel(router: router)
        case .machineDetail:
            return MachineDetailViewModel(router: router)
        }
    }
}
