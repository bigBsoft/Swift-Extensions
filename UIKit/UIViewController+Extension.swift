//
//  UIViewController+Extension.swift
//
//  Created by Bishal Ghimire on 5/21/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//

import UIKit

public extension UIViewController {
  
  static func makeWindowsRootController(_ vc: UIViewController) {
    let window = UIApplication.shared.windows.first
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
      window!.rootViewController = vc
      window?.makeKeyAndVisible()
    }
  }
  
  func makeRootController() {
    let window = UIApplication.shared.windows.first
    let oldView = window!.rootViewController!.view
    UIView.transition(from: oldView!,
                      to: view,
                      duration: 0.2,
                      options: .transitionCrossDissolve,
      completion: { completed in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
          oldView?.removeFromSuperview()
          window!.rootViewController = self
          window?.makeKeyAndVisible()
        }
    })
    window?.rootViewController?.dismiss(animated: true, completion: nil)
  }
  
}

extension UIViewController {
  
  /// Short hand syntax for loading the view controller
  func loadViewProgrammatically(){
    beginAppearanceTransition(true, animated: false)
    endAppearanceTransition()
  }
  
}

extension UIWindow {
  
  func replaceRootViewControllerWith(_ replacementController: UIViewController, animated: Bool, completion: (() -> Void)?) {
    let snapshotImageView = UIImageView(image: self.snapshot())
    addSubview(snapshotImageView)
    rootViewController!.dismiss(animated: false, completion: { // dismiss all modal view controllers
      self.rootViewController = replacementController
      self.bringSubview(toFront: snapshotImageView)
      if animated {
        UIView.animate(withDuration: 0.2,
        animations: {
          snapshotImageView.alpha = 0
        },
        completion: { success in
            snapshotImageView.removeFromSuperview()
            completion?()
        })
      } else {
        snapshotImageView.removeFromSuperview()
        completion?()
      }
    })
  }
  
}


// http://www.totem.training/swift-ios-tips-tricks-tutorials-blog/ux-chops-dim-the-lights

enum Direction { case `in`, out }

protocol Dimmable { }

extension Dimmable where Self: UIViewController {
  
  func dim(_ direction: Direction,
           color: UIColor = UIColor.black,
           alpha: CGFloat = 0.0,
           speed: Double = 0.0) {
    
    switch direction {
    case .in:
      
      // Create and add a dim view
      let dimView = UIView(frame: view.frame)
      dimView.backgroundColor = color
      dimView.alpha = 0.0
      view.addSubview(dimView)
      
      // Deal with Auto Layout
      dimView.translatesAutoresizingMaskIntoConstraints = false
      view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[dimView]|", options: [], metrics: nil, views: ["dimView": dimView]))
      view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimView]|", options: [], metrics: nil, views: ["dimView": dimView]))
      
      // Animate alpha (the actual "dimming" effect)
      UIView.animate(withDuration: speed, animations: {
        dimView.alpha = alpha
      }) 
      
    case .out:
      UIView.animate(withDuration: speed, animations: {
        self.view.subviews.last?.alpha = alpha 
        }, completion: { (complete) -> Void in
          self.view.subviews.last?.removeFromSuperview()
      })
    }
  }
  
}

public  extension UIViewController {
  
  func preloadView() {
    _ = view
  }
  
}
