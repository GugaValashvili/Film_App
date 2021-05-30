//
//  FilmsCollectionViewController.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCellIdentifier"

class FilmsCollectionViewController: UICollectionViewController {

    private var page: Int? = 1
    private var dataStore: Movies = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FilmPosterViewCell.nib, forCellWithReuseIdentifier: reuseIdentifier)
        fetchData()
    }
    
    private func fetchData() {
        guard let page = page else {
            return
        }
        Methods.discover(page: page, filterType: .none)
            .fetch(ResultEntity<Movies>.self) { [weak self] result in
            switch result {
            case let .success(response):
                self?.didFetched(response: response)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func didFetched(response: ResultEntity<Movies>) {
        guard let page = response.page else {
            self.page = nil
            return
        }
        let nextPage = page + 1
        if (response.totalPages ?? 0) >= nextPage {
            self.page = nextPage
        }
        didFetched(movies: response.results ?? [])
    }

    private func didFetched(movies: Movies) {
        dataStore.append(contentsOf: movies)
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataStore.count
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == dataStore.count - 5 {
            fetchData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let item = dataStore[indexPath.item]
        (cell as? FilmPosterViewCell)?.configure(posterPath: item.posterPath)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataStore[indexPath.item]
        openDetail(movie: item)
    }

    private func openDetail(movie: Movie) {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        dvc.movie = movie
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

extension FilmsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count: CGFloat = 3
        var maxWidth = collectionView.bounds.width
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            maxWidth -= flowLayout.sectionInset.left
            maxWidth -= flowLayout.sectionInset.right
            maxWidth -= ((count - 1) * flowLayout.minimumInteritemSpacing)
        }
        let width = floor(maxWidth / count)
        let height = width * (3/2)
        return CGSize(width: width, height: height)
    }
}
