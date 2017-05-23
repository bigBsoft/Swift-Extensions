//
//  NSData+Extension.swift
//
//  Created by Bishal Ghimire on 9/16/16.
//  Copyright © 2016 bigBsoft. All rights reserved.
//

import Foundation

extension Data {
  
  func dictionary() -> NSDictionary? {
    return try! JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? NSDictionary
  }
  
  func array() -> NSArray? {
    return try! JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? NSArray
  }
  
}

// For Notification

extension Data {
  public var hexString: String {
    var string = ""
    
    enumerateBytes { (buffer, _, _) in
      buffer.forEach({ (byte) in
        string = string.appendingFormat("%02x", byte)
      })
    }
    
    return string
  }
}
