//
//  ViewController.swift
//  UIButtonAnimate
//
//  Created by Ivan Magda on 26/03/2018.
//  Copyright © 2018 Ivan Magda. All rights reserved.
//

import UIKit

// MARK: ViewController: UIViewController

final class ViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet var containerView: UIView!

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: Actions

    @IBAction func onPulse(_ sender: UIButton) {
        sender.pulsate()
    }

    @IBAction func onFlash(_ sender: UIButton) {
        sender.flash()
    }
    
    @IBAction func onShake(_ sender: UIButton) {
        sender.shake()
    }
    
}

// MARK: - ViewController (Private Helpers) -

extension ViewController {

    private func setup() {
        for subview in containerView.subviews where subview is UIButton {
            subview.layer.cornerRadius = 10
        }
    }

}
