//
//  UIButton+Animate.swift
//  UIButtonAnimate
//
//  Created by Ivan Magda on 26/03/2018.
//  Copyright © 2018 Ivan Magda. All rights reserved.
//

import UIKit

// MARK: UIButton (Animate)

extension UIButton {

    func pulsate() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.duration = 0.6
        animation.fromValue = 0.95
        animation.toValue = 1.0
        animation.autoreverses = true
        animation.repeatCount = 2
        animation.initialVelocity = 0.5
        animation.damping = 1.0

        layer.add(animation, forKey: nil)
    }

    func flash() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 0.5
        animation.fromValue = 1.0
        animation.toValue = 0.1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = 3

        layer.add(animation, forKey: nil)
    }

    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true

        let fromValue = NSValue(cgPoint: CGPoint(x: center.x - 5, y: center.y))
        let toValue   = NSValue(cgPoint: CGPoint(x: center.x + 5, y: center.y))

        animation.fromValue = fromValue
        animation.toValue = toValue

        layer.add(animation, forKey: nil)
    }

}
