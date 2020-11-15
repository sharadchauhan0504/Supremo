//
//  HomeScreenViewModel.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import Foundation

class HomeScreenViewModel {
    
    func getRecentSearches() -> [SearchedResult] {
        guard let recent = RecentSearchManager<SearchedResult>.getCustomObjects(UserDefaultsKeys.recentSearches.key) else {return [SearchedResult]()}
        return recent
    }
}
