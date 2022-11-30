//
//  IModule.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation
import UIKit

protocol IModule {
    var router: IRouter { get set }
    func resolve(using params: [String: Any]) -> UIViewController
}
