//
//  ViewController.swift
//  PickerView
//
//  Created by Ivan Magda on 27/03/2018.
//  Copyright © 2018 Ivan Magda. All rights reserved.
//

import UIKit

// MARK: ViewController: UIViewController

final class ViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet var textField: UITextField!

    // MARK: Instance Variables

    private let dayPickerDelegate = DayPickerViewDelegate()

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

// MARK: - ViewController (Actions) -

extension ViewController {

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

}

// MARK: - ViewController (Private Helpers) -

extension ViewController {

    private func setup() {
        dayPickerDelegate.onSelect = { [weak self] (_, title) in
            self?.textField.text = title
        }

        let picker = UIPickerView()
        picker.backgroundColor = .black
        picker.delegate = dayPickerDelegate
        picker.dataSource = dayPickerDelegate

        textField.inputView = picker

        addToolbar()
    }

    private func addToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(ViewController.dismissKeyboard)
        )

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        toolBar.barTintColor = .black
        toolBar.tintColor = .white

        textField.inputAccessoryView = toolBar
    }

}
