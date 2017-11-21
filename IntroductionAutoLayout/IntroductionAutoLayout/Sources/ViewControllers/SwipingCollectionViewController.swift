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
  Page(imageName: "bear_first", headerText: "Join us today in our fun and games!",
          bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
  Page(imageName: "heart_second", headerText: "Subscribe and get coupons on our daily events",
          bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
  Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: "")
]

// MARK: SwipingCollectionViewController: UICollectionViewController

class SwipingCollectionViewController: UICollectionViewController {

  // MARK: Instance Variables

  private let previousButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("PREV", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.gray, for: .normal)
    button.addTarget(self, action: #selector(onPrevious), for: .touchUpInside)

    return button
  }()

  private let nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("NEXT", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(UIColor.mainPink, for: .normal)
    button.addTarget(self, action: #selector(onNext), for: .touchUpInside)

    return button
  }()

  private let pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.numberOfPages = pages.count
    pageControl.currentPageIndicatorTintColor = UIColor.mainPink
    pageControl.pageIndicatorTintColor = UIColor.tuftBush
    pageControl.addTarget(self, action: #selector(onPageChanged), for: .touchUpInside)

    return pageControl
  }()

  // MARK: Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)

    coordinator.animate(alongsideTransition: { _ in
      self.collectionViewLayout.invalidateLayout()

      if self.pageControl.currentPage == 0 {
        self.collectionView?.contentOffset = .zero
      } else {
        self.setPage(index: self.pageControl.currentPage)
      }
    }, completion: nil)
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

  // MARK: UIScrollViewDelegate

  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let x = targetContentOffset.pointee.x
    pageControl.currentPage = Int(x / view.frame.width)
  }

  // MARK: Action

  @objc private func onPrevious() {
    setPage(index: pageControl.currentPage - 1)
  }

  @objc private func onNext() {
    setPage(index: pageControl.currentPage + 1)
  }

  @objc private func onPageChanged() {
    setPage(index: pageControl.currentPage)
  }

  // MARK: Private

  private func setup() {
    assert(collectionView != nil)

    collectionView?.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView?.backgroundColor = .white
    collectionView?.isPagingEnabled = true
    collectionView?.showsHorizontalScrollIndicator = false

    setupBottomControls()
  }

  private func setPage(index: Int) {
    guard index >= 0 && index < pages.count else {
      return
    }

    pageControl.currentPage = index
    collectionView?.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
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

  private func setupBottomControls() {
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

  private func configure(_ cell: PageCollectionViewCell, atIndexPath indexPath: IndexPath) {
    let pageData = pages[indexPath.item]
    cell.page = pageData
  }

}
