//
//  DayPickerViewDelegate.swift
//  PickerView
//
//  Created by Ivan Magda on 27/03/2018.
//  Copyright © 2018 Ivan Magda. All rights reserved.
//

import UIKit

final class DayPickerViewDelegate: NSObject {

    private static let days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
    ]

    var onSelect: ((Int, String) -> Swift.Void)? = nil

}

// MARK: DayPickerViewDelegate: UIPickerViewDataSource

extension DayPickerViewDelegate: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DayPickerViewDelegate.days.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return DayPickerViewDelegate.days[row]
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        let label: UILabel

        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }

        label.textColor = .cyan
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .black)
        label.text = DayPickerViewDelegate.days[row]

        return label
    }

}

// MARK: DayPickerViewDelegate: UIPickerViewDelegate

extension DayPickerViewDelegate: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onSelect?(row, DayPickerViewDelegate.days[row])
    }

}
