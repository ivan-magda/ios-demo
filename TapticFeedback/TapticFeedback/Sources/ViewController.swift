//
//  ViewController.swift
//  TapticFeedback
//
//  Created by Ivan Magda on 27/03/2018.
//  Copyright © 2018 Sean Allen. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var tapticButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in tapticButtons {
            button.layer.cornerRadius = button.frame.size.height/2
        }
    }

    // MARK: UINotificationFeedbackGenerator

    // Use notification feedback to communicate that a task or action has succeeded,
    // failed, or produced a warning of some kind.

    @IBAction func errorButtonTapped(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    @IBAction func successButtonTapped(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    @IBAction func warningButtonTapped(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }

    // MARK: UIImpactFeedbackGenerator

    // Use impact feedback to indicate that an impact has occurred.
    // For example, you might trigger impact feedback when a user interface
    // object collides with another object or snaps into place.

    @IBAction func lightButtonTapped(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    @IBAction func mediumButtonTapped(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    @IBAction func heavyButtonTapped(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }

    // MARRK: UISelectionFeedbackGenerator

    // Use selection feedback to communicate movement through a series of discrete values.

    @IBAction func selectionButtonTapped(_ sender: UIButton) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

