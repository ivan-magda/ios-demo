//
//  ViewController.swift
//  Gradient
//
//  Created by Ivan Magda on 27/03/2018.
//  Copyright © 2018 Ivan Magda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var rectangle: UIView!
    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)

        view.applyGradient(colors: [.black, .darkGray])
        rectangle.applyGradient(colors: [.white, .blue])
        button.applyGradient(colors: [.orange, .red])
    }

}
