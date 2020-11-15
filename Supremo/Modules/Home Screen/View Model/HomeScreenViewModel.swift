//
//  HomeScreenViewModel.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import Foundation

class HomeScreenViewModel {
    
    func getRecentSearches() -> [SearchedResult] {
        return RecentSearchManager<SearchedResult>.getCustomObjects(UserDefaultsKeys.recentSearches.key)
    }
}
