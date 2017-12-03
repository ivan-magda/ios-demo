/**
 * Copyright (c) 2017 Ivan Magda
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

// MARK: ContactsHeaderViewCell: UITableViewHeaderFooterView

final class ContactsHeaderViewCell: UITableViewHeaderFooterView {

  typealias ActionButtonDidPressedCallback = (UIButton) -> Void

  // MARK: Instance Variables

  private var actionButtonDidPressedCallback: ActionButtonDidPressedCallback? = { _ in }

  private lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()

  private lazy var actionButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(actionButtonDidPressed), for: .touchUpInside)

    return button
  }()

  // MARK: Init

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }

  init(_ actionButtonDidPressed: ActionButtonDidPressedCallback?) {
    super.init(reuseIdentifier: ContactsHeaderViewCell.identifier)

    self.actionButtonDidPressedCallback = actionButtonDidPressed
    sharedInit()
  }

  // MARK: Private

  @objc private func actionButtonDidPressed(sender: UIButton) {
    actionButtonDidPressedCallback?(sender)
  }

}

// MARK: - Public API -

extension ContactsHeaderViewCell {

  var titleText: String? {
    get {
      return label.text
    }
    set(newText) {
      label.text = newText
    }
  }

  var actionTitle: String? {
    get {
      return actionButton.titleLabel?.text
    }
    set(newText) {
      actionButton.setTitle(newText, for: .normal)
    }
  }

  static let defaultHeight: CGFloat = 44.0

}

// MARK: - Utilities -

extension ContactsHeaderViewCell {
  private func sharedInit() {
    contentView.addSubview(label)
    contentView.addSubview(actionButton)

    actionButton.setTitleColor(tintColor, for: .normal)

    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      label.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
      actionButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      actionButton.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
      actionButton.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 8)
    ])
  }
}

// MARK: - ContactsHeaderViewCell (Tint Color) -

extension ContactsHeaderViewCell {
  override func tintColorDidChange() {
    super.tintColorDidChange()
    actionButton.setTitleColor(tintColor, for: .normal)
  }
}
