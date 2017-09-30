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
  
  private let bearImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let descriptionTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = "Join us today in our fun and games!"
    textView.font = UIFont.boldSystemFont(ofSize: 18)
    textView.textAlignment = .center
    textView.isEditable = false
    textView.isScrollEnabled = false
    return textView
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
  }
  
  private func addBearImageView() {
    view.addSubview(bearImageView)
    
    NSLayoutConstraint.activate([
      bearImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      bearImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
    ])
  }
  
  private func addDescriptionTextView() {
    view.addSubview(descriptionTextView)
    
    NSLayoutConstraint.activate([
      descriptionTextView.topAnchor.constraint(equalTo: bearImageView.bottomAnchor, constant: 100),
      descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor),
      descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
  }
  
}
