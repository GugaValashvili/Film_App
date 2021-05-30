//
//  Movie.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import Foundation

typealias Movies = [Movie]

struct Movie: Codable {

    let title: String?
    let posterPath: String?
    let overview: String?
    let originalTitle: String?
    let voteAverage: Double?
    let releaseDate: String?
}
