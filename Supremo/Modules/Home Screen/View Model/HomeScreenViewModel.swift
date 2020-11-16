//
//  HomeScreenViewModel.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import Foundation

class HomeScreenViewModel {
    
    func getRecentlyViewed() -> [SearchedResult] {
        return RecentSearchManager<SearchedResult>.getCustomObjects(UserDefaultsKeys.recentlyViewed.key)
    }
}
