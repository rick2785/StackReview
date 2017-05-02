//
//  Label.swift
//  StackReview
//
//  Created by Rickey Hrabowskie on 5/1/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

@IBDesignable
class MultilineLabelThatWorks : UILabel {
  @IBInspectable
  var respectMargins : Bool = false {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    preferredMaxLayoutWidth = bounds.width
    super.layoutSubviews()
  }
  
  override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    if respectMargins {
      var rect = layoutMargins.apply(bounds)
      rect = super.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
      return layoutMargins.inverse.apply(rect)
    } else {
      return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
    }
  }
  
  override func drawText(in rect: CGRect) {
    let newRect : CGRect
    if respectMargins {
      newRect = layoutMargins.apply(rect)
    } else {
      newRect = rect
    }
    super.drawText(in: newRect)
  }
}

extension UIEdgeInsets {
  var inverse : UIEdgeInsets {
    return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
  }
  func apply(_ rect: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(rect, self)
  }
}
