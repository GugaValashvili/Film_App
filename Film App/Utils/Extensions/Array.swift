//
//  Array.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import Foundation

extension Array {
    func value(at index: Int) -> Element? {
        if self.indices.contains(index) {
           return self[index]
        }
        return nil
    }
}
