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

private let fileToDownloadUrlString = "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_2mb.mp4"

// MARK: ViewController: UIViewController

class ViewController: UIViewController {
  
  // MARK: Instance Variables
  
  private lazy var shapeLayer: CAShapeLayer = {
    return getCircularShape()
  }()

  private lazy var pulsatingLayer: CAShapeLayer = {
    return getCircularShape()
  }()
  
  private let percentageLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 32)
    label.textColor = .white
    label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    return label
  }()
  
  private lazy var urlSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    let queue = OperationQueue()
    let session = URLSession(configuration: configuration, delegate: self,
                             delegateQueue: queue)
    
    return session
  }()
  
  private var downloadTask: URLSessionDownloadTask? = nil
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addNotificationObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: Actions
  
  @objc private func onTap() {
    beginDownloadingFile()
  }
  
  // MARK: Private
  
  private func setup() {
    let trackLayer = getCircularShape()
    trackLayer.strokeColor = UIColor(.revolver).cgColor
    trackLayer.fillColor = UIColor(.vulcan).cgColor

    pulsatingLayer.strokeColor = UIColor.clear.cgColor
    pulsatingLayer.fillColor = UIColor(.wineBerry).cgColor

    shapeLayer.strokeEnd = 0

    view.layer.addSublayer(pulsatingLayer)
    view.layer.addSublayer(trackLayer)
    view.layer.addSublayer(shapeLayer)
    view.backgroundColor = UIColor(.vulcan)
    view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                     action: #selector(onTap)))
    
    percentageLabel.center = view.center
    view.addSubview(percentageLabel)
    
    updateDownloadProgress(0)
    animatePulsatingLayer()
  }
  
  private func beginDownloadingFile() {
    if let downloadTask = downloadTask {
      downloadTask.cancel()
    }
    
    guard let url = URL(string: fileToDownloadUrlString) else {
      return print(#function, " Failed to download file.")
    }
    
    updateDownloadProgress(0)
    
    downloadTask = urlSession.downloadTask(with: url)
    downloadTask!.resume()
  }
  
  private func addNotificationObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleEnterForeground),
                                           name: .UIApplicationWillEnterForeground,
                                           object: nil)
  }
  
  @objc private func handleEnterForeground() {
    animatePulsatingLayer()
  }
  
}

// MARK: - ViewController - (UI) -

extension ViewController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private func getCircularShape() -> CAShapeLayer {
    let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0,
                                    endAngle: 2 * CGFloat.pi, clockwise: true)
    
    let layer = CAShapeLayer()
    layer.path = circularPath.cgPath
    layer.fillColor = UIColor.clear.cgColor
    layer.strokeColor = UIColor(.ruby).cgColor
    layer.lineWidth = 10
    layer.lineCap = kCALineCapRound
    layer.position = view.center
    layer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
    
    return layer
  }
  
  private func animateCircle() {
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.toValue = 1
    animation.duration = 0.75
    animation.fillMode = kCAFillModeForwards
    animation.isRemovedOnCompletion = false
    
    shapeLayer.add(animation, forKey: "strokeEndAnimation")
  }

  private func animatePulsatingLayer() {
    let animation = CABasicAnimation(keyPath: "transform.scale")
    animation.toValue = 1.3
    animation.duration = 0.75
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animation.autoreverses = true
    animation.repeatCount = Float.infinity
    
    pulsatingLayer.add(animation, forKey: "pulsating")
  }
  
  private func updateDownloadProgress(_ progress: CGFloat) {
    shapeLayer.strokeEnd = progress
    percentageLabel.text = "\(Int(progress * 100)) %"
  }
  
}

// MARK: - ViewController: URLSessionDownloadDelegate -

extension ViewController: URLSessionDownloadDelegate {
  
  func urlSession(_ session: URLSession,
                  downloadTask: URLSessionDownloadTask,
                  didWriteData bytesWritten: Int64,
                  totalBytesWritten: Int64,
                  totalBytesExpectedToWrite: Int64) {
    let percentage = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
    
    onMain {
      self.updateDownloadProgress(CGFloat(percentage))
    }
    
    print(percentage * 100)
  }
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                  didFinishDownloadingTo location: URL) {
    print(#function)
  }
  
}
