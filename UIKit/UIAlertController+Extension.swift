//
//  UIAlertController+Extension.swift
//
//  Created by Bishal Ghimire on 7/28/16.
//  Copyright © 2016 bigBsoft. All rights reserved.
//

import UIKit

extension UIAlertController {
  
  func showAndHide() {
    present(true, hide: true, completion: nil)
  }
  
  func show() {
    present(true, hide: false, completion: nil)
  }
  
  func present(_ animated: Bool, hide: Bool, completion: (() -> Void)?) {
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
      presentFromController(rootVC, animated: animated, hide: hide, completion: completion)
    }
  }
  
  fileprivate func presentFromController(_ controller: UIViewController,
                                     animated: Bool,
                                     hide: Bool,
                                     completion: (() -> Void)?) {
    if  let navVC = controller as? UINavigationController,
      let visibleVC = navVC.visibleViewController {
      presentFromController(visibleVC, animated: animated, hide: hide, completion: completion)
    } else {
      if  let tabVC = controller as? UITabBarController,
        let selectedVC = tabVC.selectedViewController {
        presentFromController(selectedVC, animated: animated, hide: hide, completion: completion)
      } else {
        controller.present(self, animated: animated, completion: completion)
      }
    }
    
    if hide {
      delay(2) {
        self.dismiss(animated: true, completion: nil)
      }
    }
  }
  
}
