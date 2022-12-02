//
//  Extension+Date.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import Foundation

extension Date {
    func toString(with format: String) -> String {
        return Helper.epochConverter(date: "",
                                          epoch: self.timeIntervalSince1970 * 1000,
                                          format: format)
    }
}
