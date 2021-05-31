//
//  FilmPosterViewCell.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import UIKit
import SDWebImage

class FilmPosterViewCell: UICollectionViewCell {

    static let nib = UINib(nibName: "FilmPosterViewCell", bundle: .main)

    @IBOutlet private weak var posterImageView: UIImageView!

    func configure(posterPath: String?) {
        let url = URL(string: API.baseImagePath + (posterPath ?? ""))
        posterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Logo"))
    }
}
