//
//  FilmsCollectionViewController.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import UIKit

class FilmsCollectionViewController: UICollectionViewController {

    private let movieReuseIdentifier = "MovieCellIdentifier"
    private let filterReuseIdentifier = "FilterViewCellIdentifier"
    
    private var page: Int? = 1
    private var filterType: MovieFilterType = .all
    
    private var dataStore: Movies = []
    private lazy var filterCellDataModel = FilterViewCellDataModel { [weak self] type in
        self?.didChange(filter: type)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FilmPosterViewCell.nib, forCellWithReuseIdentifier: movieReuseIdentifier)
        collectionView.register(FilterViewCell.nib, forCellWithReuseIdentifier: filterReuseIdentifier)
        title = "Movies App"
        fetchData()
    }

    private func fetchData() {
        guard let page = page else {
            return
        }
        view.activityStartAnimating()
        Methods.discover(page: page, filterType: filterType.networkType)
            .fetch(ResultEntity<Movies>.self) { [weak self] result in
            switch result {
            case let .success(response):
                self?.didFetched(response: response)
                self?.view.activityStopAnimating()
            case let .failure(error):
                if let apiError = error as? APIError, case .api(let serverError) = apiError {
                    self?.showAlert(alertText: "Something went wrong", alertMessage: serverError.statusMessage)
                } else {
                    self?.showAlert(alertText: "Something went wrong", alertMessage: error.localizedDescription)
                }
                
                self?.view.activityStopAnimating()
            }
        }
    }

    private func fetchLocalData() {
        let data = CoreDataStack.shared.fetch()
        self.didFetched(movies: data)
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

    private func didChange(filter type: MovieFilterType) {
        if filterType == type { return }
        filterType = type
        dataStore.removeAll()
        collectionView.reloadData()
        if type == .favorite {
            page = nil
            fetchLocalData()
        } else {
           page = 1
        }
        fetchData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : dataStore.count
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == dataStore.count - 5 {
            fetchData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath)
            (cell as? FilterViewCell)?.configure(model: filterCellDataModel)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieReuseIdentifier, for: indexPath)
        let item = dataStore.value(at: indexPath.item)
        (cell as? FilmPosterViewCell)?.configure(posterPath: item?.posterPath)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 { return }
        if let item = dataStore.value(at: indexPath.item) {
            openDetail(movie: item)
        }
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
        
        if indexPath.section == 0 {
            return CGSize(width: maxWidth, height: 52)
        }
        
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
