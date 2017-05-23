//
//  MBProgressHUD+Extension.swift
//
//  Created by Bishal Ghimire on 8/4/16.
//  Copyright © 2016 bigBsoft. All rights reserved.
//

import MBProgressHUD

extension MBProgressHUD {

  static func setupForView(_ view: UIView) -> MBProgressHUD {
    let progressHUD = MBProgressHUD(view: view)
    progressHUD.mode = .indeterminate
    progressHUD.animationType = .fade
    view.addSubview(progressHUD)
    return progressHUD
  }
  
  func showLoadingMessage(_ message: String) {
    mode = .indeterminate
    detailsLabel.text = message
    show(animated: true)
  }
  
  func showToastMessage(_ message: String) {
    detailsLabel.text = message
    hide(animated: true, afterDelay: 0.8)
  }

  /// Shows Checkmark and Hides after 0.8 sec
  func showSucessMessage(_ message: String) {
    customView = UIImageView(image: UIImage(named: "37x-checkmark"))
    mode = .customView
    detailsLabel.text = message
    show(animated: true)
    hide(animated: true, afterDelay: 0.8)
  }
  
  func showSucess(message: String, completion: @escaping () -> ()) {
    customView = UIImageView(image: UIImage(named: "37x-checkmark"))
    mode = .customView
    detailsLabel.text = message
    show(animated: true)
    hide(animated: true, afterDelay: 0.8)
    delay(0.8) {
     completion()
    }
  }
  
  func showFailureMessage(_ message: String) {
    customView = UIImageView(image: UIImage(named: "37x-crossmark"))
    mode = .customView
    detailsLabel.text = message
    show(animated: true)
    hide(animated: true, afterDelay: 1.0)
  }
  
}
