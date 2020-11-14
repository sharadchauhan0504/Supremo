//
//  RawJSONOverHTTP.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import Foundation

final class RawJSONOverHTTP {
    
    static func dataFrom<T: Codable>(from: T?) -> Data? {
        guard let encoded = try? JSONEncoder().encode(from) else {
            return nil
        }
        return encoded
    }
    
    static func jsonFrom(data: Data?) -> String? {
        guard let properData = data else {
            return nil
        }
        let convertedString = String(data: properData, encoding: String.Encoding.utf8)
        return convertedString
    }
}
