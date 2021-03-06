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

import UIKit.UIColor

extension UIColor {
  
  enum ColorType {
    case revolver
    case ruby
    case vulcan
    case wineBerry
  }
  
  convenience init(_ colorType: ColorType) {
    switch colorType {
    case .revolver:
      self.init(red: 0.20, green: 0.08, blue: 0.16, alpha: 1.00)
    case .ruby:
      self.init(red: 0.85, green: 0.05, blue: 0.39, alpha: 1.00)
    case .vulcan:
      self.init(red: 0.07, green: 0.08, blue: 0.11, alpha: 1.00)
    case .wineBerry:
      self.init(red: 0.36, green: 0.11, blue: 0.24, alpha: 1.00)
    }
  }
  
}
