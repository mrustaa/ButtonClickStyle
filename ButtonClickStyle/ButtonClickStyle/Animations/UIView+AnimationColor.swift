
import UIKit

extension UIView {
  
  // MARK: - Color inversion
  
  func inversionColor(duration: CGFloat, cornRadius: CGFloat? = nil, value: UIColor) { // .s1
    
    let v = UIView(frame: frame)
    v.backgroundColor = value.inverted
    v.layer.compositingFilter = "differenceBlendMode"
    addSubview(v)
  }
  
  
  // MARK: - Change Color
  
  func DesignableViewBorderUpdate() {
    if let desFig = self as? DesignableView, desFig.brWidth != 0 {
      
      if desFig.brWidth != 0 {
        layer.borderColor = desFig.brColor.cgColor
        //        desFig.brColor = .clear
        
        layer.borderWidth = desFig.brWidth
        desFig.brWidth = 0
        layer.cornerRadius = desFig.cornerRadius
        
        desFig.setNeedsLayout()
      }
    }
  }
  
  func animationColorTouchDown(cornRadius: CGFloat? = nil, color: UIColor, alpha: CGFloat) { // .s1
    
    
    let from = color.withAlphaComponent(alpha)
    
    if let label = self as? UILabel {
      label.textColor = from
    }
    else if let desFig = self as? DesignableView,  desFig.brColor != .clear {
      DesignableViewBorderUpdate()

      layer.borderColor = from.cgColor
    } else {
      backgroundColor = from
    }
  }
  
  func animationColor(duration: CGFloat, cornRadius: CGFloat? = nil, color: UIColor, alpha: CGFloat) { // .s1
    
//    return;
    
    let from = color.withAlphaComponent(alpha)
    let fromColor = from.cgColor
    
    //    if border {
    
    
    
    if let label = self as? UILabel {
      
      
      var to: UIColor = label.textColor
      if let desLab = self as? DesignableLabel, let grColor = desLab.grColor1 {
        to = grColor
      }
      
      //      label.textColor = from
      
      //      main(delay: 0.1) {
      
      UIView.transition(
        with: label,
        duration: 0.01,
        options: .transitionCrossDissolve,
        animations: {
          
          label.textColor = from
        }, completion: { fin in
          
          UIView.transition(
            with: label,
            duration: duration - 0.05,
            options: .transitionCrossDissolve,
            animations: {
              label.textColor = to
            }
          )
          
        })
      //      }
      
      
    }
    
    else if let desFig = self as? DesignableView, desFig.brColor != .clear {
      DesignableViewBorderUpdate()
    
      let to = desFig.brColor
      layer.borderColor = to.cgColor

      
      let animation2 = CABasicAnimation(keyPath: "borderColor")
      animation2.fromValue = from.cgColor
      animation2.toValue = to.cgColor
      animation2.duration = duration
//              animation2.beginTime = CACurrentMediaTime() + 0.1
//              animation2.autoreverses = false
      layer.add(animation2, forKey: "animationColor")
      layer.borderColor = to.cgColor
      
    } else {
      
      
      //        let fills = layer.sublayers?.filter {
      //          $0.name == "fill"
      //        }
      //        fills?.forEach {
      //          $0.removeFromSuperlayer()
      //        }
      
      let toColor = UIColor.clear.cgColor
      
      let animation = CABasicAnimation(keyPath: "backgroundColor")
      animation.fromValue = fromColor    //UIColor.white.cgColor
      animation.toValue = toColor
      animation.duration = duration
      //      animation.beginTime = CACurrentMediaTime() + 0.1
      //      animation.autoreverses = false
      
      layer.cornerRadius = radiusSearch(cornRadius)
      layer.add(animation, forKey: "animationColor")
      backgroundColor = .clear
      
    }
  }
  
  func radiusSearch(_ cornRadius: CGFloat? = nil) -> CGFloat {
    if let r = cornRadius { return r }
    guard let mainView = self.superview else { return 0 }
    var radius = mainView.layer.cornerRadius
    if radius == 0 {
      for sv in mainView.subviews {
        if sv.layer.cornerRadius != 0 {
          radius = mainView.layer.cornerRadius
        }
        if let desFig = mainView as? DesignableView {
          radius = desFig.cornerRadius
          if radius == -1 {
            let minSize =  min(mainView.frame.width, mainView.bounds.height)
            radius = minSize / 2
          }
        }
      }
    }
    return radius
  }
}

extension UIColor {
  var inverted: UIColor {
    var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a) // Assuming you want the same alpha value.
  }
}
