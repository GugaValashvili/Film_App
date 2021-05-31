//
//  MovieDetailsViewController.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailsViewController: UIViewController {

    var movie: Movie?

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var originalNameLabel: UILabel!
    @IBOutlet private weak var raitingLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var addFavoriteButton: UIButton!
    @IBOutlet private weak var addFavoriteImageView: UIImageView!
    
    private var coreDataStack: CoreDataStack {
        CoreDataStack.shared
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = self.movie else {
            fatalError()
        }
        configure(movie: movie)
    }

    private func configure(movie: Movie) {
        self.title = movie.title
        configureFavoriteButton(movie: movie)
        let url = URL(string: API.baseImagePath + (movie.posterPath ?? ""))
        posterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Logo"))
        titleLabel.text = movie.title
        originalNameLabel.text = movie.originalTitle
        raitingLabel.text = "\(movie.voteAverage ?? 0)"
        releaseDateLabel.text = movie.releaseDate
        summaryLabel.text = movie.overview
    }

    @IBAction func favoriteAction() {
        guard let movie = movie else { return }
        view.activityStartAnimating()
        if let entity = coreDataStack.movie(with: movie.id ?? 0) {
            coreDataStack.delete(entity: entity)
        } else {
            coreDataStack.save(movie: movie)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.view.activityStopAnimating()
            self.configureFavoriteButton(movie: movie)
        }
    }

    private func configureFavoriteButton(movie: Movie) {
        if coreDataStack.movie(with: movie.id ?? 0) != nil {
            addFavoriteButton.setTitle("Remove from Favorite", for: .normal)
            addFavoriteButton.setTitleColor(.red, for: .normal)
            addFavoriteImageView.image = UIImage(named: "RemoveFavorite")
        } else {
            addFavoriteButton.setTitle("Add to Favorite", for: .normal)
            addFavoriteButton.setTitleColor(.black, for: .normal)
            addFavoriteImageView.image = UIImage(named: "AddFavorite")
        }
    }
}
