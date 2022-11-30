//
//  Extension+Codable.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 01/12/22.
//

import Foundation

extension Decodable {
    static func decode(from data: Data?) -> Self? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}
