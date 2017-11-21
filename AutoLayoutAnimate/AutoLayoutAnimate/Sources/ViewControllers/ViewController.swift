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

private let imageViewSize: CGFloat = 100
private let imageViewMargin: CGFloat = 16

// MARK: ViewController: UIViewController

class ViewController: UIViewController {

  // MARK: Instance Variables

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "minion"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                          action: #selector(onImagePress)))

    return imageView
  }()

  private var leadingAnchor: NSLayoutConstraint!
  private var trailingAnchor: NSLayoutConstraint!
  private var topAnchor: NSLayoutConstraint!
  private var bottomAnchor: NSLayoutConstraint!

  private var corner: Corner = .topLeft

  // MARK: View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  // MARK: - Private

  private func setup() {
    prepareUI()
  }

  // MARK: Actions

  @objc private func onImagePress() {
    animateImageView()
  }

}

// MARK: ViewController (UI)

extension ViewController {

  private func prepareUI() {
    addImageView()
  }

  private func addImageView() {
    view.addSubview(imageView)

    leadingAnchor = imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: imageViewMargin)
    trailingAnchor = imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -imageViewMargin)
    topAnchor = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: imageViewMargin)
    bottomAnchor = imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -imageViewMargin)

    activateImageViewConstraints()
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: imageViewSize),
      imageView.heightAnchor.constraint(equalToConstant: imageViewSize)
    ])
  }

  private func animateImageView() {
    corner = corner.next()
    activateImageViewConstraints()

    UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 10,
                   initialSpringVelocity: 15, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
    }, completion: nil)
  }

  private func activateImageViewConstraints() {
    switch corner {
    case .topLeft:
      leadingAnchor.isActive = true
      trailingAnchor.isActive = false
      topAnchor.isActive = true
      bottomAnchor.isActive = false
    case .topRight:
      leadingAnchor.isActive = false
      trailingAnchor.isActive = true
      topAnchor.isActive = true
      bottomAnchor.isActive = false
    case .bottomRight:
      leadingAnchor.isActive = false
      trailingAnchor.isActive = true
      topAnchor.isActive = false
      bottomAnchor.isActive = true
    case .bottomLeft:
      leadingAnchor.isActive = true
      trailingAnchor.isActive = false
      topAnchor.isActive = false
      bottomAnchor.isActive = true
    }
  }
}
