//
//  SuperHeroAPIService.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import Foundation

enum SuperHeroAPIService: Routable {
    
    case search(_ query: String)
    
    var url: URL? {
        switch self {
        case .search: return URL(string: APIClient.baseUrl.urlString + endPoint)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search: return .GET
        }
    }
    
    var endPoint: String {
        switch self {
        case .search(let query): return "/search/\(query)"
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .search: return [
            "Content-Type": "application/json"
        ]
        }
    }
    
    var body: Data? {
        switch self {
        case .search: return nil
        }
    }
    
    var request: URLRequest? {
        guard let url = self.url else {return nil}
        var request                 = URLRequest(url: url)
        request.httpMethod          = self.method.rawValue
        request.allHTTPHeaderFields = self.headers
        request.httpBody            = self.body
        request.cachePolicy         = .reloadRevalidatingCacheData
        return request
    }
    
    
}
