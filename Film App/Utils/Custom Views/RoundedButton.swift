//
//  RoundedButton.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedParameters()
    }

    private func setNeedParameters() {
        self.layer.cornerRadius = min(self.bounds.height, self.bounds.width) * 0.5
        self.layer.masksToBounds = true
    }
}

