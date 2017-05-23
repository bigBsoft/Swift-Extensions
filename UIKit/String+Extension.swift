//
//  String+Extension.swift
//
//  Created by Bishal Ghimire on 4/30/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//

import UIKit

public extension String {
  
  var encode: String {
    let urlSet = NSMutableCharacterSet()
    urlSet.formUnion(with: .urlFragmentAllowed)
    urlSet.formUnion(with: .urlHostAllowed)
    urlSet.formUnion(with: .urlPasswordAllowed)
    urlSet.formUnion(with: .urlQueryAllowed)
    urlSet.formUnion(with: .urlUserAllowed)

    return self.addingPercentEncoding(withAllowedCharacters: urlSet as CharacterSet)!
  }
  
  var first: String {
    return String(characters.prefix(1))
  }
  
  var last: String {
    return String(characters.suffix(1))
  }
  
  var uppercaseFirst: String {
    return first.uppercased() + String(characters.dropFirst())
  }
  
  var isValidEmail: Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
  }
  
  var shortString: String {
    var sString: String = ""
    let wordsArray = self.characters.split{$0 == " "}.map(String.init)
    
    for word in wordsArray {
      sString += word[0]
      if(sString.characters.count >= 2){
        break
      }
    }
    return  sString
  }
  
  var trimmedWhiteSpace: String {
    let trimmedString = trimmingCharacters(in: CharacterSet.whitespaces)
    return trimmedString.replacingOccurrences(of: " ", with: "")
  }
  
  subscript (i: Int) -> Character {
    return self[self.characters.index(self.startIndex, offsetBy: i)]
  }
  
  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }

}

/// Extension of String for Design - to bound in the given frames

public extension String {
  
  func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    return boundingBox.height
  }

}
