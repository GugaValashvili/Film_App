//
//  Movie.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import Foundation
import CoreData

typealias Movies = [Movie]

struct Movie: Codable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let overview: String?
    let originalTitle: String?
    let voteAverage: Double?
    let releaseDate: String?
}

extension MovieEntity {
    func convertToMovie() -> Movie {
        Movie(id: Int(id), title: title, posterPath: posterPath, overview: overview, originalTitle: originalTitle, voteAverage: voteAverage, releaseDate: releaseDate)
    }
}
