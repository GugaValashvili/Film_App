//
//  Method.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import Foundation
enum Methods {
    
    enum FilterType: String {
        case populary = "popularity.desc"
        case mostRated = "vote_average.desc"
    }
    
    case discover(page: Int, filterType: FilterType?)
    
    var path: String {
        switch self {
        case let .discover(page, filterType):
            if let filterType = filterType {
                return "discover/movie?page=\(page)&sort_by=\(filterType.rawValue)"
            }
            return "discover/movie?page=\(page)"
        }
        
//
//        let queryItems = [URLQueryItem(name: "id", value: "1"), URLQueryItem(name: "id", value: "2")]
//        var urlComps = URLComponents(string: "www.apple.com/help")!
//        urlComps.queryItems = queryItems
//        let result = urlComps.url!
    }
    
}
extension Methods {
    func fetch<T: Decodable>(_ type: T.Type, complition: @escaping (Result<T, Error>) -> Void) {
        NetworkManager.shared.getRequest(type, path: path, complition: complition)
    }
}
