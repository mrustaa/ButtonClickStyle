
import UIKit

extension UIView {
  
  // MARK: - Android Pulse
  
  public func buttonClickStyleAndroidPulse(radius: CGFloat, duration: CGFloat, color: UIColor? = nil, value: CGFloat? = nil, position: CGPoint) {
    
    var rcolor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2786076018)
    
    if let color = color {
      rcolor = color .withAlphaComponent(0.75)
    }
    
    if let alpha = value {
      rcolor = rcolor.withAlphaComponent(alpha)
    }
    
    let to = 0 + (radius * 400) // 200
    
    let pulse = ButtonClickStylePulseAnimation(numberOfPulse: 1, radius: to, postion: position)
    pulse.animationDuration = duration
    pulse.backgroundColor = rcolor.cgColor
    layer.insertSublayer(pulse, below: layer)
  }
  
}

//MARK: - extensions


