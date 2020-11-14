//
//  RecentSearchManager.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import Foundation

enum UserDefaultsKeys {
    case recentSearches
    
    var key: String {
        switch self {
        case .recentSearches: return "Supremo-recentSearches"
        }
    }
}

struct RecentSearchManager<T: Codable> {
    
    static func saveCustomObjects(_ object: T, _ key: String) {
        var data = [T]()
        if let savedData = RecentSearchManager<T>.getCustomObjects(key) {
            data = savedData
        }
        data.append(object)
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
    
    static func getCustomObjects(_ key: String) -> [T]? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([T].self, from: data)
                return decoded
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return nil
    }
}
