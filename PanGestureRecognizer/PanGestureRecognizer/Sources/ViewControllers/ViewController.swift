//
//  ViewController.swift
//  PanGestureRecognizer
//
//  Created by Ivan Magda on 27/03/2018.
//  Copyright © 2018 Ivan Magda. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet var documentImageView: UIImageView!
    @IBOutlet var trashImageView: UIImageView!

    // MARK: Instance Variables

    private var documentImageViewCenter: CGPoint!

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: - ViewController (Private Helpers) -

extension ViewController {

    private func setup() {
        view.bringSubview(toFront: documentImageView)
        documentImageViewCenter = documentImageView.center

        addPanGestureRecognizer()
    }

}

// MARK: - ViewController (PanGestureRecognizer) -

extension ViewController {

    private func addPanGestureRecognizer() {
        let pan = UIPanGestureRecognizer(
            target: self,
            action: #selector(ViewController.handlePan(_:))
        )

        documentImageView.addGestureRecognizer(pan)
    }

    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let attachedView = recognizer.view else { return }

        switch recognizer.state {
        case .began, .changed:
            moveViewWithPan(attachedView, recognizer: recognizer)
        case .ended:
            if documentImageView.frame.intersects(trashImageView.frame) {
                hideView(documentImageView)
            } else {
                set(origin: documentImageViewCenter, view: documentImageView)
            }
        default:
            break
        }
    }

    private func moveViewWithPan(_ attachedView: UIView,
                                 recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)

        attachedView.center = CGPoint(
            x: attachedView.center.x + translation.x,
            y: attachedView.center.y + translation.y
        )

        recognizer.setTranslation(.zero, in: view)
    }

    private func hideView(_ view: UIView, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.33) {
                view.alpha = 0.0
            }
        } else {
            view.alpha = 0.0
        }
    }

    private func set(origin: CGPoint, view: UIView, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.33) {
                view.center = origin
            }
        } else {
            view.center = origin
        }
    }

}
