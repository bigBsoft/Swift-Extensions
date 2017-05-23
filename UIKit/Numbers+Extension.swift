//
//  Numbers+Extension.swift
//
//  Created by Bishal Ghimire on 7/1/16.
//  Copyright © 2016 bigBsoft. All rights reserved.
//

import CoreGraphics

public extension Int {
  var cgFloat: CGFloat { return CGFloat(self) }
  var f: Float { return Float(self) }
  var string: String { return "\(self)" }
}

public extension Float {
  var cgFloat: CGFloat { return CGFloat(self) }
  var string: String { return "\(self)" }
  var intString: String {
    let i = Int(self)
    return "\(i)"
  }
}

public extension Double {
  var cgFloat: CGFloat { return CGFloat(self) }
}

public extension CGFloat {
  var f: Float { return Float(self) }
}
