//
//  ServerErrorEntity.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import Foundation

struct ServerErrorEntity: Codable {
    var success: Bool
    var statusMessage: String
    var statusCode: Int
}
