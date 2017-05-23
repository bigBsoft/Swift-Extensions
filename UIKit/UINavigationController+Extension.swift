//
//  UINavigationController+Extension.swift
//
//  Created by Bishal Ghimire on 6/30/16.
//  Copyright © 2016 bigBsoft. All rights reserved.
//

import Foundation
import UIKit

public extension UINavigationController {
  
  func transparentNavigationBar(_ isTransparent: Bool) {
    if isTransparent {
      navigationBar.setBackgroundImage(UIImage(), for: .default)
      navigationBar.isTranslucent = true
      navigationBar.shadowImage = UIImage()
      navigationBar.backgroundColor = UIColor.clear
    } else {
      navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
  }

}
