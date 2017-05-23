//
//  UITextField+Extension.swift
//
//  Created by Bishal Ghimire on 6/13/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//

import UIKit

extension UITextView {
  
  override func scrollToBottom() {
    self.scrollRangeToVisible(NSMakeRange(self.text.characters.count - 1, 1))
  }
  
}


public extension UITextField {
  
  public func placeholderText(_ text: String, forColor color: UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)) {
    attributedPlaceholder = NSAttributedString(string: text,
                                           attributes: [NSForegroundColorAttributeName: color])
  }
  
}
