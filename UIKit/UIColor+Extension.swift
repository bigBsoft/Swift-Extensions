//
//  UIColor+Extension.swift
//
//  Created by Bishal Ghimire on 4/30/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    let red     = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let green   = CGFloat((hex & 0xFF00) >> 8) / 255.0
    let blue    = CGFloat((hex & 0xFF)) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
  
  func darker(_ amount: CGFloat) -> UIColor {
    return hueColorWithBrightnessAmount(1 - amount)
  }
  
  func lighter(_ amount: CGFloat) -> UIColor {
    return hueColorWithSaturationAmount(1 - amount)
  }
  
  fileprivate func hueColorWithBrightnessAmount(_ amount: CGFloat) -> UIColor {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0
    
    if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
      return UIColor(hue: hue,
                     saturation: saturation,
                     brightness: brightness * amount,
                     alpha: alpha)
    } else {
      return self
    }
  }
  
  fileprivate func hueColorWithSaturationAmount(_ amount: CGFloat) -> UIColor {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0
    
    if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
      return UIColor(hue: hue ,
                     saturation: saturation * amount,
                     brightness: brightness,
                     alpha: alpha)
    } else {
      return self
    }
  }
  
  static func gradientColor(_ green: Double, red: Double) -> UIColor {
    return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: 0.0, alpha: 1.0)
  }
  
  func shadeOfColors(forCount count: Int) -> [UIColor]? {
    guard count > 0 else { return nil }
    var value:CGFloat = 0.1
    var colors = [UIColor]()
    colors.append(self)
    for _ in 1...(count - 1) {
      colors.append(lighter(value))
      value += (0.8 / count.cgFloat)
    }
    return colors
  }
  
}
