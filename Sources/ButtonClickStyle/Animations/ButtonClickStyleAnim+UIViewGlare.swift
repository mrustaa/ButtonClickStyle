//
//  UIView+AnimationGlare\.swift
//  ButtonClickStyle_Example
//
//  Created by Рустам Мотыгуллин on 11.04.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
  
  public func buttonClickStyleGlare(alpha: CGFloat, color: UIColor? = nil, duration: CGFloat? = nil) {
    
//    let snapshot = self.asImage().withRenderingMode(.alwaysTemplate)
    let snapshot = self.snapshot().withRenderingMode(.alwaysTemplate)
    let imageView = UIImageView(image: snapshot)
    
    var clr: UIColor = UIColor(white: 0.9, alpha: alpha)
    if let color = color {
      clr = color.withAlphaComponent(alpha)
    }
    imageView.tintColor = clr
    let image = imageView.snapshot()
//    let image = imageView.asImage()// else { return }
    
    let width = image.size.width
    let height = image.size.height
    let shineLayer = CALayer()
    shineLayer.contents = image.cgImage
    shineLayer.frame = bounds
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [UIColor.clear.cgColor,
                            UIColor.black.withAlphaComponent(0.55).cgColor,
                            UIColor.black.cgColor,
                            UIColor.black.withAlphaComponent(0.55).cgColor,
                            UIColor.clear.cgColor]
    gradientLayer.locations = [0.0, 0.35, 0.50, 0.65, 0.0]
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.15)
    
    gradientLayer.frame = CGRect(x: -width, y: 0, width: width, height: height)
    let animation = CABasicAnimation(keyPath: "position.x")
    animation.byValue = width * 2
    animation.duration = duration ?? 1.25
    animation.repeatCount = Float.greatestFiniteMagnitude
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    
    layer.addSublayer(shineLayer)
    shineLayer.mask = gradientLayer
    
    gradientLayer.add(animation, forKey: "shine")
  }
  
  public func buttonClickStyleGlareStop() {
    layer.sublayers?.forEach {
      $0.mask?.removeAnimation(forKey: "shine")
    }
  }
}
