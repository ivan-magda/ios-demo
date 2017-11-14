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

// MARK: ViewController: UIViewController

class ViewController: UIViewController {
  
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
  
  private let previousButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("PREV", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.gray, for: .normal)
    
    return button
  }()
  
  private let nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("NEXT", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(UIColor.mainPink, for: .normal)
    
    return button
  }()
  
  private let pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.numberOfPages = 4
    pageControl.currentPageIndicatorTintColor = UIColor.mainPink
    pageControl.pageIndicatorTintColor = UIColor(red: 249/255.0, green: 207/255.0, blue: 224/255.0, alpha: 1.0)
    
    return pageControl
  }()
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
}

// MARK: - ViewController (Configure UI) -

extension ViewController {
  
  private func configureUI() {
    addBearImageView()
    addDescriptionTextView()
    addBottomControls()
  }
  
  private func addBearImageView() {
    view.addSubview(topImageViewContainer)
    NSLayoutConstraint.activate([
      topImageViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
      topImageViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
      topImageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topImageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    topImageViewContainer.addSubview(bearImageView)
    NSLayoutConstraint.activate([
      bearImageView.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor),
      bearImageView.centerYAnchor.constraint(equalTo: topImageViewContainer.centerYAnchor),
      bearImageView.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.5)
    ])
  }
  
  private func addDescriptionTextView() {
    view.addSubview(descriptionTextView)
    
    NSLayoutConstraint.activate([
      descriptionTextView.topAnchor.constraint(equalTo: topImageViewContainer.bottomAnchor),
      descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
      descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
    ])
  }
  
  private func addBottomControls() {
    let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
    bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
    bottomControlsStackView.distribution = .fillEqually
    
    view.addSubview(bottomControlsStackView)
    
    NSLayoutConstraint.activate([
      bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
}
