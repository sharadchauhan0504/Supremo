//
//  SearchSuperHeroesErrorOutput.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import Foundation

// MARK: - SearchSuperHeroesErrorOutput
struct SearchSuperHeroesErrorOutput: Codable {
    let response, error: String
}


struct RecentSearches: Codable, Equatable {
    let query: String
    
    static func == (lhs: RecentSearches, rhs: RecentSearches) -> Bool {
        return lhs.query == rhs.query
    }
}
