//
//  UIButton+AllAnimations.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 20.08.2021.
//

import UIKit


extension UIView {
  
  // MARK: - Shake
  
  func buttonClickStyleShake(value: CGFloat, duration: CGFloat) {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = duration // 0.6
    
    let to = 5 + (value * 30.0)
    //    print(" ❤️‍🔥 shake \(to) ")
    let offset: CGFloat = to  // 20.0
    animation.values = [-offset, offset, -offset, offset, -(offset/2), (offset/2), -(offset/4), (offset/4), 0.0 ]
    layer.add(animation, forKey: "shake")
  }
  
  // MARK: - Shake 2
  
  func buttonClickStyleShakeNew(value: CGFloat, duration: CGFloat) {
    
    let shake = CABasicAnimation(keyPath: "position")
    shake.duration = duration
    shake.repeatCount = 2
    shake.autoreverses = true
    
    let to = -10 + (value * 30)
    //    print(" 🧡 shake new \(to) ")
    let fromPoint = CGPoint(x: center.x - to, y: center.y)
    let fromValue = NSValue(cgPoint: fromPoint)
    
    let toPoint = CGPoint(x: center.x + to, y: center.y)
    let toValue = NSValue(cgPoint: toPoint)
    
    shake.fromValue = fromValue
    shake.toValue = toValue
    
    layer.add(shake, forKey: "position")
  }
  
}
