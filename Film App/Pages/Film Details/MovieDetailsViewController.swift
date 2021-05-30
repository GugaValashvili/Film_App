//
//  MovieDetailsViewController.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var movie: Movie?

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var originalName: UILabel!
    @IBOutlet private weak var raitingLabel: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = self.movie else {
            fatalError()
        }
        configure(movie: movie)
    }

    private func configure(movie: Movie) {
        self.title = movie.title
        let url = URL(string: API.baseImagePath + (movie.posterPath ?? ""))
        posterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = movie.title
        originalName.text = movie.originalTitle
        raitingLabel.text = "\(movie.voteAverage ?? 0)"
        releaseDate.text = movie.releaseDate
        summaryLabel.text = movie.overview
    }
}
