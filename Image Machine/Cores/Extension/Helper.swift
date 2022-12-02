//
//  Helper.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import Foundation
import UIKit

struct Helper {
    static func epochConverter(date: String, epoch: Double, format: String) -> String {
        var timeResult = Double()
        if date == "" {
            timeResult = epoch / 1000
        }else if let doubleDate = Double(date) {
            timeResult = doubleDate / 1000
        }
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    static func dateConverter(_ dateStr: String, format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        let localDate = dateFormatter.date(from: dateStr) ?? Date()
        return localDate
    }
}
