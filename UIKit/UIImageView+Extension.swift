//
//  UIImageView+Extension.swift
//
//  Created by Bishal Ghimire on 5/26/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//
// https://github.com/ridvank/UIImageViewWithWords


import UIKit

public extension UIImageView {
  
  func imageWithString(_ word: String) {
    self.imageWithString(word, color: nil, circular: true)
  }
  
  func imageWithString(_ word: String, color: UIColor?) {
    self.imageWithString(word, color: color, circular: true)
  }
  
  func imageWithString(_ word: String, circular: Bool) {
    self.imageWithString(word, color: nil, circular: circular)
  }
  
  func imageWithString(_ word: String, color: UIColor?, circular: Bool){
    self.imageWithString(word, color: color, circular: circular, fontAttributes: nil)
  }
  
  func imageWithString(_ word: String, color: UIColor?, circular: Bool, fontAttributes: [String : AnyObject]?){
    var imageViewString: String = ""
    
    let wordsArray = word.characters.split{$0 == " "}.map(String.init)
    
    for word in wordsArray {
      imageViewString += word[0]
      if (imageViewString.characters.count >= 2) {
        break
      }
    }
    
    imageSnapShotFromWords(imageViewString, color: color, circular: circular, fontAttributes: fontAttributes)
  }
  
  func imageSnapShotFromWords(_ snapShotString: String, color: UIColor?, circular: Bool, fontAttributes: [String : AnyObject]?) {
    
    var attributes: [String : AnyObject]?
    
    if let attr = fontAttributes {
      attributes = attr
    }
    else {
      attributes = [
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont.systemFont(ofSize: self.bounds.width * 0.4)
      ]
    }
    
    var imageBackgroundColor = UIColor()
    
    if let color = color {
      imageBackgroundColor = color
    }
    else {
      imageBackgroundColor = generateRandomColor()
    }
    
    let scale: CGFloat = UIScreen.main.scale
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, scale)
    
    let context = UIGraphicsGetCurrentContext()
    
    if(circular){
      
      self.layer.cornerRadius = self.frame.width/2
      self.clipsToBounds = true
      
    }
    
    context!.setFillColor(imageBackgroundColor.cgColor)
    context!.fill(CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    
    let textSize = (snapShotString as NSString).size(attributes: attributes)
    
    (snapShotString as NSString).draw(in: CGRect(x: bounds.size.width / 2 - textSize.width / 2,
      y: bounds.size.height / 2 - textSize.height / 2,
      width: textSize.width,
      height: textSize.height), withAttributes: attributes)
    
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    self.image = image
  }
  
  func generateRandomColor() -> UIColor {
    let hue : CGFloat = CGFloat(arc4random() % 256) / 256
    let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
    let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
    
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
  }
  
}
