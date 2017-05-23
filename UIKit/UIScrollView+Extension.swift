//
//  UIScrollView+Extension.swift
//
//  Created by Bishal Ghimire on 6/13/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//

import UIKit

extension UIScrollView {
  
  func scrollToTop() {
    let topOffset = CGPoint(x: 0, y: 0)
    self.setContentOffset(topOffset, animated: true)
  }
  
  func scrollToBottom() {
    let top: CGFloat = self.contentInset.top
    let bottomOffset = CGPoint(x: 0, y: top + self.contentSize.height - self.bounds.size.height)
    self.setContentOffset(bottomOffset, animated: true)
  }
  
}
