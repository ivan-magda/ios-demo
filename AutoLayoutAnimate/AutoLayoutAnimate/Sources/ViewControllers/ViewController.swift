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

private let minionImageViewSize: CGFloat = 100

// MARK: ViewController: UIViewController

class ViewController: UIViewController {
  
  // MARK: Instance Variables
  
  private lazy var minionImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "minion"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                          action: #selector(onMinionImagePress)))
    
    return imageView
  }()
  
  private var leadingAnchor: NSLayoutConstraint!
  private var trailingAnchor: NSLayoutConstraint!
  private var topAnchor: NSLayoutConstraint!
  private var bottomAnchor: NSLayoutConstraint!
  
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
  
  @objc private func onMinionImagePress() {
    animateMinionImageView()
  }

}

// MARK: ViewController (UI)

extension ViewController {
  
  private func prepareUI() {
    addMinionImageView()
  }
  
  private func addMinionImageView() {
    view.addSubview(minionImageView)
    
    leadingAnchor = minionImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
    trailingAnchor = minionImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    topAnchor = minionImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    bottomAnchor = minionImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    
    NSLayoutConstraint.activate([
      leadingAnchor,
      topAnchor,
      minionImageView.widthAnchor.constraint(equalToConstant: minionImageViewSize),
      minionImageView.heightAnchor.constraint(equalToConstant: minionImageViewSize)
    ])
  }
  
  private func animateMinionImageView() {
    self.leadingAnchor.isActive = false
    self.trailingAnchor.isActive = true
    self.topAnchor.isActive = false
    self.bottomAnchor.isActive = true
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,
                   initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
}
