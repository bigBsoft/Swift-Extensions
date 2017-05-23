//
//  UIAlertAction+Extension.swift
//
//  Created by Bishal Ghimire on 8/30/16.
//  Copyright © 2016 bigBsoft. All rights reserved.
//

import UIKit

extension UIAlertAction {
  
  func addImage(_ image: UIImage) {
    setValue(image, forKey: "image")
  }

}
