//
//  ResponseModel.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import Foundation

struct ResultEntity<T: Codable>: Codable {
    let page: Int?
    let results: T?
    let totalPages: Int?
    let totalResults: Int?
}
