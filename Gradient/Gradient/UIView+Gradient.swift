//
//  UIView+Gradient.swift
//  Gradient
//
//  Created by Ivan Magda on 27/03/2018.
//  Copyright © 2018 Ivan Magda. All rights reserved.
//

import UIKit

extension UIView {

    func applyGradient(colors: [UIColor], locations: [NSNumber] = [0.0, 1.0]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

}
