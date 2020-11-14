//
//  APIClient.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import Foundation

enum APIClient {
    
    case baseUrl
    
    var urlString: String {
        switch self {
        case .baseUrl: return "https://superheroapi.com/api/\(SuperHeroAPIConstants.accessToken)/"
        }
    }
}
