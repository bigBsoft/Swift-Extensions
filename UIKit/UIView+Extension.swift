//
//  UIView+Extension.swift
//
//  Created by Bishal Ghimire on 4/30/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//

import UIKit

//
// View for UILabel Accessory - Activity Indicator View
//

extension UIView {

  func activityIndicatorView() -> UIView {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    activityIndicator.color = UIColor(red: 0.3098, green: 0.8549, blue: 0.3333, alpha: 1.0)
    return activityIndicator
  }
  
}

// http://stackoverflow.com/a/34679549

extension UIView {
  
  func snapshot() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
    drawHierarchy(in: bounds, afterScreenUpdates: true)
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result!
  }
  
}

//
//  Layout Helper
//

extension UIView {
  
  func moveToBottomOfView(_ viewRect: CGRect) {
    let rectHeight = frame.height
    let rectWidth = frame.width
    let x = frame.minX
    
    self.frame = CGRect(x: x,
                        y: viewRect.height - rectHeight,
                        width: rectWidth,
                        height: rectHeight)
  }
  
  func moveToBelowTheView(_ viewRect: CGRect, padding: CGFloat) {
    let rectHeight = frame.height
    let rectWidth = frame.width
    let x = frame.minX
    
    self.frame = CGRect(x: x,
                        y: viewRect.height + padding,
                        width: rectWidth,
                        height: rectHeight)
  }
  
  func centerToViewRect(_ rect: CGRect, forView viewRect: CGRect) -> CGRect {
    let rectHeight = rect.height
    let rectWidth = rect.width
    
    return CGRect(x: rectWidth / 2 -  viewRect.width,
                  y: rectHeight / 2 - viewRect.height,
                  width: viewRect.width,
                  height: viewRect.height)
  }
  
  func verticallyCenterToViewRect(_ rect: CGRect, forView viewRect: CGRect) {
    let rectHeight = rect.height
    self.frame = CGRect(x: viewRect.minX,
                        y: rectHeight / 2 - viewRect.height,
                        width: viewRect.width,
                        height: viewRect.height)
  }
  
  func horizontallyCenterToViewRect(_ rect: CGRect) {
    let rectWidth = rect.width
    self.frame = CGRect(x: rectWidth / 2 -  frame.width / 2,
                        y: frame.minY,
                        width: frame.width,
                        height: frame.height)
  }
  
}

// https://github.com/objcio/S01E03-loading-view-controllers

extension UIView {
  
  public func constrainHeight(_ constant: CGFloat) {
    NSLayoutConstraint.activate([NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)])
  }
  
  public func constrainWidth(_ constant: CGFloat) {
    NSLayoutConstraint.activate([NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)])
  }
  
  public func constrainEqual(_ attribute: NSLayoutAttribute, to: AnyObject, multiplier: CGFloat = 1, constant: CGFloat = 0) {
    constrainEqual(attribute, to: to, attribute, multiplier: multiplier, constant: constant)
  }
  
  public func constrainEqual(_ attribute: NSLayoutAttribute, to: AnyObject, _ toAttribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: to, attribute: toAttribute, multiplier: multiplier, constant: constant)
      ]
    )
  }
  
  public func constrainEdges(toMarginOf view: UIView) {
    constrainEqual(.top, to: view, .topMargin)
    constrainEqual(.leading, to: view, .leadingMargin)
    constrainEqual(.trailing, to: view, .trailingMargin)
    constrainEqual(.bottom, to: view, .bottomMargin)
  }
  
  public func paddingTopLeft(toView view: UIView, padding: CGFloat) {
    constrainEqual(.top, to: self, multiplier: 1, constant: padding)
    constrainEqual(.leading, to: self, multiplier: 1, constant: padding)
  }
  
  public func paddingTopRight(toView view: UIView, padding: CGFloat) {
    constrainEqual(.top, to: self, multiplier: 1, constant: padding)
    constrainEqual(.trailing, to: self, multiplier: 1, constant: padding)
  }
  
  public func paddingTopLeftRight(toView view: UIView, padding: CGFloat) {
    constrainEqual(.top, to: self, multiplier: 1, constant: padding)
    constrainEqual(.leading, to: self, multiplier: 1, constant: padding)
    constrainEqual(.trailing, to: view, .trailingMargin)
  }
  
  public func center(inView view: UIView) {
    centerXAnchor.constrainEqual(view.centerXAnchor)
    centerYAnchor.constrainEqual(view.centerYAnchor)
  }
  
}

extension NSLayoutAnchor {
  
  public func constrainEqual(_ anchor: NSLayoutAnchor, constant: CGFloat = 0) {
    let constraint = self.constraint(equalTo: anchor, constant: constant)
    constraint.isActive = true
  }
  
}

// http://stackoverflow.com/a/25877866/1294448
/**
 *  Convenience category for manipulating UIView frames
 */
extension UIView {
  
  //MARK: - Getters
  func frameX() -> CGFloat {
    return frame.origin.x
  }
  
  func frameY() -> CGFloat {
    return frame.origin.y
  }
  
  func frameWidth() -> CGFloat {
    return frame.size.width
  }
  
  func frameHeight() -> CGFloat {
    return frame.size.height
  }
  
  //MARK: - Setters
  func setFrameX(_ x: CGFloat) {
    frame = CGRect(x: x, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
  }
  
  func setFrameY(_ y: CGFloat) {
    frame = CGRect(x: frame.origin.x, y: y, width: frame.size.width, height: frame.size.height)
  }
  
  func setFrameWidth(_ width: CGFloat) {
    frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: frame.size.height)
  }
  
  func setFrameHeight(_ height: CGFloat) {
    frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: height)
  }
}
