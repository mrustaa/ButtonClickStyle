//
//  UIButton+AllAnimations.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 20.08.2021.
//

import UIKit

public extension UIView {
  
  // MARK: - Flash
  
  func buttonClickStyleFlash(value: CGFloat, duration: CGFloat) {
    
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = duration
    flash.fromValue = 1
    let to = (1.0 - value)
    flash.toValue = to // 0.1
    flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 3
    
    layer.add(flash, forKey: nil)
  }
  
}
