//
//  UIButton+AllAnimations.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 20.08.2021.
//

import UIKit

extension UIView {
  
  
  // MARK: - Pulsate
  
  public func buttonClickStylePulsate(value: CGFloat, duration: CGFloat) {
    
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = duration
    pulse.fromValue = 1.0
    let to = 0.45 + ((1.0 - value)  * 0.8)
    pulse.toValue =  to // 0.85
    pulse.autoreverses = true
    pulse.repeatCount = 2
    pulse.initialVelocity = 0.5
     
    
    layer.add(pulse, forKey: "pulse")
  }
  
  // MARK: - Pulsate 2
  
  public func buttonClickStylePulsateNew(duration: CGFloat, value: CGFloat, visible: Bool) {
    if visible {
      animate(duration: duration, view: self, transform: .identity)
    } else {
      let to = 0.45 + ((1.0 - value)  * 0.8)
      animate(duration: duration, view: self, transform: CGAffineTransform.identity.scaledBy(x: to, y: to))
    }
  }
  
  public func animate(duration: CGFloat, view: UIView, transform: CGAffineTransform) {
    UIView.animate(withDuration: duration, // 0.4,
                   delay: 0,
                   usingSpringWithDamping: 0.5,
                   initialSpringVelocity: 3,
                   options: [.curveEaseInOut],
                   animations: {
      view.transform = transform
    }, completion: nil)
  }
  
  
  
}
