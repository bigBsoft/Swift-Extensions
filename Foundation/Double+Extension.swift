//
//  Double+Extension.swift
//
//  Created by Bishal Ghimire on 4/30/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//

import Foundation

extension Double {
  
  var timeFormat: String {
    let time = Int(self)
    let mins = Int(time / 60)
    let min = mins < 10 ? "0\(mins)" : "\(mins)"
    let secs = Int(time % 60)
    let sec = secs < 10 ? "0\(secs)" : "\(secs)"
    return "\(min):\(sec)"
  }
  
}
