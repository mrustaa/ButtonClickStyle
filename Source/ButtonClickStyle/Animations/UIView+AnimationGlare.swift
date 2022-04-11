//
//  UIView+AnimationGlare\.swift
//  ButtonClickStyle_Example
//
//  Created by Рустам Мотыгуллин on 11.04.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
  
  func buttonClickStyleGlare(alpha: CGFloat, color: UIColor? = nil, duration: CGFloat? = nil) {
    
//    let snapshot = self.asImage().withRenderingMode(.alwaysTemplate)
    let snapshot = self.snapshot?.withRenderingMode(.alwaysTemplate)
    let imageView = UIImageView(image: snapshot)
    // Add it image view and render close to white
    var clr: UIColor = UIColor(white: 0.9, alpha: alpha)
    if let color = color {
      clr = color.withAlphaComponent(alpha)
    }
    imageView.tintColor = clr
    guard let image = imageView.snapshot  else { return }
//    let image = imageView.asImage()// else { return }
    
    let width = image.size.width
    let height = image.size.height
    // Create CALayer and add light content to it
    let shineLayer = CALayer()
    shineLayer.contents = image.cgImage
    shineLayer.frame = bounds
    
    // create CAGradientLayer that will act as mask clear = not shown, opaque = rendered
    // Adjust gradient to increase width and angle of highlight
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
    // Create CA animation that will move mask from outside bounds left to outside bounds right
    let animation = CABasicAnimation(keyPath: "position.x")
    animation.byValue = width * 2
    // How long it takes for glare to move across button
    animation.duration = duration ?? 1.25
    // Repeat forever
    animation.repeatCount = Float.greatestFiniteMagnitude
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    
    layer.addSublayer(shineLayer)
    shineLayer.mask = gradientLayer
    
    // Add animation
    gradientLayer.add(animation, forKey: "shine")
  }
  
  func buttonClickStyleGlareStop() {
    // Search all sublayer masks for "shine" animation and remove
    layer.sublayers?.forEach {
      $0.mask?.removeAnimation(forKey: "shine")
    }
  }
}

extension UIView {
  // Helper to snapshot a view
  var snapshot: UIImage? {
    let renderer = UIGraphicsImageRenderer(size: bounds.size)
    
    let image = renderer.image { context in
      layer.render(in: context.cgContext)
    }
    return image
  }
}
