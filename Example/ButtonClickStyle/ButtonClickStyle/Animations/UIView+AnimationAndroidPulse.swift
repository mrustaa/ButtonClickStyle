//
//  UIButton+AllAnimations.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 20.08.2021.
//

import UIKit

public extension UIView {
  
  // MARK: - Android Pulse
  
  func buttonClickStyleAndroidPulse(radius: CGFloat, duration: CGFloat, color: UIColor? = nil, value: CGFloat? = nil, position: CGPoint) {
    
    var rcolor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2786076018)
    
    if let color = color {
      rcolor = color .withAlphaComponent(0.75)
    }
    
    if let alpha = value {
      rcolor = rcolor.withAlphaComponent(alpha)
    }
    
    let to = 0 + (radius * 400) // 200
//    print(" 💙💜 androidPulse \(to) ")
    
    let pulse = ButtonClickStylePulseAnimation(numberOfPulse: 1, radius: to, postion: position)
    pulse.animationDuration = duration
    pulse.backgroundColor = rcolor.cgColor// #colorLiteral(red: 0.05282949957, green: 0.5737867104, blue: 1, alpha: 1)
    layer.insertSublayer(pulse, below: layer)
  }
  
}

//MARK: - extensions


