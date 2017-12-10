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
  
  private lazy var shapeLayer: CAShapeLayer = {
    return getCircularShape()
  }()

  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: Actions
  
  @objc private func onTap() {
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.toValue = 1
    animation.duration = 0.75
    animation.fillMode = kCAFillModeForwards
    animation.isRemovedOnCompletion = false
    
    shapeLayer.add(animation, forKey: "strokeEndAnimation")
  }
  
  // MARK: Private
  
  private func setup() {
    let trackLayer = getCircularShape()
    trackLayer.strokeColor = UIColor(.revolver).cgColor
    
    shapeLayer.strokeEnd = 0
    
    view.layer.addSublayer(trackLayer)
    view.layer.addSublayer(shapeLayer)
    view.backgroundColor = UIColor(.vulcan)
    view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                     action: #selector(onTap)))
  }
  
  private func getCircularShape() -> CAShapeLayer {
    let center = view.center
    let circularPath = UIBezierPath(arcCenter: center, radius: 100,
                                    startAngle: -CGFloat.pi / 2,
                                    endAngle: 2 * CGFloat.pi, clockwise: true)
    
    let layer = CAShapeLayer()
    layer.path = circularPath.cgPath
    layer.fillColor = UIColor.clear.cgColor
    layer.strokeColor = UIColor(.ruby).cgColor
    layer.lineWidth = 10
    layer.lineCap = kCALineCapRound
    
    return layer
  }
  
}
