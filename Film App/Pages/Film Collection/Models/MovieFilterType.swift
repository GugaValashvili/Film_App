//
//  MovieFilterType.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import Foundation

enum MovieFilterType {
    case all
    case popular
    case topRated
    case favorite

    var networkType: Methods.FilterType? {
        switch self {
        case .popular:
            return .populary
        case .topRated:
            return .mostRated
        case .all:
            return .none
        case .favorite:
            return nil
        }
    }
}
