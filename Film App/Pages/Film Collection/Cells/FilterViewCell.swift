//
//  FilterViewCell.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import UIKit

class FilterViewCell: UICollectionViewCell {
    
    static let nib = UINib(nibName: "FilterViewCell", bundle: .main)

    private var viewModel: FilterViewCellDataModel?
    @IBOutlet private weak var allButton: UIButton!
    @IBOutlet private weak var popularButton: UIButton!
    @IBOutlet private weak var topRatedButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    @IBAction private func allAction() {
        viewModel?.currentType = .all
        setup(with: true)
        viewModel?.filterAction(.all)
    }
    
    @IBAction private func popularAction() {
        viewModel?.currentType = .popular
        setup(with: true)
        viewModel?.filterAction(.popular)
    }
    
    @IBAction private func topRatedAction() {
        viewModel?.currentType = .topRated
        setup(with: true)
        viewModel?.filterAction(.topRated)
    }
    
    @IBAction private func favoriteAction() {
        viewModel?.currentType = .favorite
        setup(with: true)
        viewModel?.filterAction(.favorite)
    }
    
    func configure(model: FilterViewCellDataModel) {
        viewModel = model
        setup(with: false)
    }

    private func setup(with animated: Bool) {
        let block = {
            self.reset()
            self.selectCurrent(type: self.viewModel?.currentType ?? .all)
        }
        if animated {
            UIView.animate(withDuration: 0.2, animations: block)
        } else {
            block()
        }
    }
    
    private func selectCurrent(type: MovieFilterType) {
        switch type {
        case .all:
            select(button: allButton)
        case .favorite:
            select(button: favoriteButton)
        case .popular:
            select(button: popularButton)
        case .topRated:
            select(button: topRatedButton)
        }
    }

    private func reset() {
        unSelect(button: allButton)
        unSelect(button: topRatedButton)
        unSelect(button: popularButton)
        unSelect(button: favoriteButton)
    }

    private func select(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }

    private func unSelect(button: UIButton) {
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
}
