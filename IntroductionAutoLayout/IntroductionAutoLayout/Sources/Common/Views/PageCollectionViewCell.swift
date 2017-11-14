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

class PageCollectionViewCell: UICollectionViewCell {

  // MARK: Instance Variables

  private let topImageViewContainer: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false

    return container
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit

    return imageView
  }()

  private let descriptionTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.isEditable = false
    textView.isScrollEnabled = false

    return textView
  }()

  var page: Page? {
    didSet {
      if let page = page {
        updateOnNewPage(page)
      }
    }
  }

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init?(coder:) has not been implemented")
  }

}

// MARK: - PageCollectionViewCell (Configure UI) -

extension PageCollectionViewCell {

  private func configureUI() {
    addImageView()
    addDescriptionTextView()
  }

  private func addImageView() {
    addSubview(topImageViewContainer)
    NSLayoutConstraint.activate([
      topImageViewContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
      topImageViewContainer.topAnchor.constraint(equalTo: topAnchor),
      topImageViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
      topImageViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])

    topImageViewContainer.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: topImageViewContainer.centerYAnchor),
      imageView.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.5)
    ])
  }

  private func addDescriptionTextView() {
    addSubview(descriptionTextView)

    NSLayoutConstraint.activate([
      descriptionTextView.topAnchor.constraint(equalTo: topImageViewContainer.bottomAnchor),
      descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
    ])
  }

  private func updateOnNewPage(_ page: Page) {
    imageView.image = UIImage(named: page.imageName)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    let attributedText = NSMutableAttributedString(string: page.headerText,
            attributes: [
              NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18),
              NSAttributedStringKey.paragraphStyle: paragraphStyle
            ]
    )
    attributedText.append(
            NSAttributedString(
                    string: "\n\n\(page.bodyText)",
                    attributes: [
                      NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
                      NSAttributedStringKey.foregroundColor: UIColor.gray,
                      NSAttributedStringKey.paragraphStyle: paragraphStyle
                    ]
            )
    )
    descriptionTextView.attributedText = attributedText
  }

}
