//
//  ViewController.swift
//  Film App
//
//  Created by Guga Valashvili on 5/29/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Methods.discover(page: 1, filterType: .none).fetch(ResultEntity<Movies>.self) { result in
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                print(error)
            }
        }
    }


}

