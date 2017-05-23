//
//  CALayer+Extension.swift
//  The New Life Challenge
//
//  Created by Bishal Ghimire on 8/4/16.
//  Copyright © 2016 bigBsoft. All rights reserved.
//

import UIKit

extension CALayer {
  
  public class func animateWithDuration(_ duration: TimeInterval, animation: () -> Void, completion: (() -> Void)?) {
    CATransaction.begin()
    CATransaction.setAnimationDuration(duration)
    CATransaction.setCompletionBlock(completion)
    animation()
    CATransaction.commit()
  }
  
}
