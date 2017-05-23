//
//  UISlider+Extension.swift
//
//  Created by Bishal Ghimire on 7/8/16.
//  Copyright © 2016 bigBsoft. All rights reserved.
//

import UIKit

extension UISlider {
  
  func gradientSlider(_ colors: [CGColor] = [UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.yellow.cgColor, UIColor.orange.cgColor, UIColor.red.cgColor]) {
    let gradientLayer = CAGradientLayer()
    let frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 5)
    gradientLayer.frame = frame
    gradientLayer.colors = colors
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.isOpaque, 0.0);
    gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    image!.resizableImage(withCapInsets: UIEdgeInsets.zero)
    
    self.setMinimumTrackImage(image, for: UIControlState())
    self.setMaximumTrackImage(image, for: UIControlState())
  }
  
}
