//
//  API.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import Foundation
struct API {
    static let baseURL = "https://api.themoviedb.org/3/"
}

enum APIError: Error {
    case networkFail
}
