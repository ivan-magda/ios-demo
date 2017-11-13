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
  
  private let bearImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let descriptionTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.isEditable = false
    textView.isScrollEnabled = false
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    let attributedText = NSMutableAttributedString(
      string: "Join us today in our fun and games!",
      attributes: [
        NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18),
        NSAttributedStringKey.paragraphStyle: paragraphStyle
      ]
    )
    attributedText.append(
      NSAttributedString(
        string: "\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.",
        attributes: [
          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
          NSAttributedStringKey.foregroundColor: UIColor.gray,
          NSAttributedStringKey.paragraphStyle: paragraphStyle
        ]
      )
    )
    textView.attributedText = attributedText
    
    return textView
  }()
  
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
    addBearImageView()
    addDescriptionTextView()
  }
  
  private func addBearImageView() {
    addSubview(topImageViewContainer)
    NSLayoutConstraint.activate([
      topImageViewContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
      topImageViewContainer.topAnchor.constraint(equalTo: topAnchor),
      topImageViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
      topImageViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
      ])
    
    topImageViewContainer.addSubview(bearImageView)
    NSLayoutConstraint.activate([
      bearImageView.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor),
      bearImageView.centerYAnchor.constraint(equalTo: topImageViewContainer.centerYAnchor),
      bearImageView.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.5)
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
  
}
