//
//  UIButton+AllAnimations.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 20.08.2021.
//

import UIKit




extension UIView {
  
  // MARK: - Android Pulse
  
  func androidPulseAnimation(radius: CGFloat, duration: CGFloat, dark: Bool, value: CGFloat? = nil, position: CGPoint) {
    
    var color = dark ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2786076018) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    if let alpha = value {
      color = color.withAlphaComponent(alpha)
    }
    
    let to = 0 + (radius * 400) // 200
//    print(" 💙💜 androidPulse \(to) ")
    
    let pulse = PulseAnimation(numberOfPulse: 1, radius: to, postion: position)
    pulse.animationDuration = duration
    pulse.backgroundColor = color.cgColor// #colorLiteral(red: 0.05282949957, green: 0.5737867104, blue: 1, alpha: 1)
    layer.insertSublayer(pulse, below: layer)
  }
  
}

//MARK: - extensions


