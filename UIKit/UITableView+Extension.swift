//
//  UITableView+Extension.swift
//
//  Created by Bishal Ghimire on 6/15/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//

import UIKit

public extension UITableView {
  
  func delayReload() {
    let delayTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime) {
      self.reloadData()
    }
  }
  
  func deselectRow() {
    guard let selectedRows = indexPathForSelectedRow else { return }
    self.deselectRow(at: selectedRows, animated: true)
  }
  
}
