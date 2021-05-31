//
//  FilterViewCellDataModel.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import Foundation

class FilterViewCellDataModel {
    
    var filterAction: ((MovieFilterType) -> Void)
    var currentType: MovieFilterType = .all
    
    init(type: MovieFilterType = .all, filterAction: @escaping ((MovieFilterType) -> Void)) {
        self.currentType = type
        self.filterAction = filterAction
    }
}

