//
//  Extension+String.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import Foundation

extension String {
    func toInt() -> Int {
        if self != "" {
            return Int(self)!
        }
        return 0
    }
}
