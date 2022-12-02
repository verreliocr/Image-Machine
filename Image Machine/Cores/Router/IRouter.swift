//
//  IRouter.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation
import UIKit

protocol IRouter: AnyObject {
    func setNavigationController(_ nav: UINavigationController)
    func setRoot(to module: FeatureModule, window: UIWindow?, using params: [String: Any])
    func push(module: FeatureModule, using params: [String: Any])
}
