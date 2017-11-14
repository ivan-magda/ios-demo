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

private let reuseIdentifier = "cellId"

private let pages = [
  Page(imageName: "bear_first", headerText: "Join use today in our fun and games!",
          bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
  Page(imageName: "heart_second", headerText: "Subscribe and get coupons on our daily events",
          bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
  Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: "")
]

// MARK: SwipingCollectionViewController: UICollectionViewController

class SwipingCollectionViewController: UICollectionViewController {

  // MARK: Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  // MARK: UICollectionViewDataSource

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PageCollectionViewCell
    configure(cell, atIndexPath: indexPath)

    return cell
  }

  // MARK: Private

  private func setup() {
    assert(collectionView != nil)

    collectionView?.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView?.backgroundColor = .white
    collectionView?.isPagingEnabled = true
  }

}

// MARK: - SwipingCollectionViewController: UICollectionViewDelegateFlowLayout -

extension SwipingCollectionViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

}

// MARK: - SwipingCollectionViewController (Configure UI) -

extension SwipingCollectionViewController {

  private func configure(_ cell: PageCollectionViewCell, atIndexPath indexPath: IndexPath) {
    let pageData = pages[indexPath.item]
    cell.page = pageData
  }

}
