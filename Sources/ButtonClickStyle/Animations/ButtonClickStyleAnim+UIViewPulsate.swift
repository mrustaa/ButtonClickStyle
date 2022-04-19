
import UIKit

extension UIView {
  
  public func buttonClickStyleFave(mainView: UIView, secondView: UIView, color: UIColor? = nil, value: CGFloat, duration: CGFloat) {
    
    let maxSize = max(mainView.frame.size.width, mainView.frame.size.height) * 0.85
    let _y = (mainView.frame.size.height / 2) - (maxSize / 2)
    let _x = (mainView.frame.size.width  / 2) - (maxSize / 2)
    
    mainView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    
    let clr = color ?? UIColor.black
    
    let circle = UIView(frame: .init(x: _x, y: _y, width: maxSize, height: maxSize))
    circle.layer.cornerRadius = maxSize / 2
    circle.backgroundColor = .clear // color ?? UIColor.black
    circle.layer.borderWidth = maxSize / 2
    circle.layer.borderColor = clr.cgColor
    circle.alpha = 0.35

    secondView .addSubview(circle)
    
    let durr = 0.35
    
    let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
    borderWidthAnimation.fromValue = circle.layer.borderWidth
    borderWidthAnimation.toValue = 0
    borderWidthAnimation.duration = durr // * 0.8
    circle.layer.add(borderWidthAnimation, forKey: "borderWidth")
    circle.layer.borderWidth = 0
    
    circle.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    
    UIView.animate(withDuration: durr ,
                   delay: 0.00,
                   usingSpringWithDamping: 2.8,
                   initialSpringVelocity: 4,
                   options: [.curveEaseOut],
                   animations: {
      circle.transform = .identity
    }, completion: nil)
    
    UIView.animate(withDuration: 0.35, // 0.4,
                   delay: 0.3,// 0.23,
                   usingSpringWithDamping: 0.38,
                   initialSpringVelocity: 10.0,
                   options: [.allowUserInteraction],
                   animations: {
      mainView.transform = .identity
      mainView.alpha = 1.0
      circle.alpha =  0.0
    }, completion: { fin in
      
      
      circle.removeFromSuperview()
    })
  }
}


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
    let to = 0.45 + ((1.0 - value)  * 0.8)
    self.layer.removeAllAnimations()
    if visible {
      self.transform = CGAffineTransform.identity.scaledBy(x: to, y: to)
        self.animate(duration: duration, view: self, transform: .identity)
      
      
    } else {
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
