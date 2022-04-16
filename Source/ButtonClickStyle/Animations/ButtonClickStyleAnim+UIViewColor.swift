
import UIKit

extension UIView {
  
  // MARK: - Color inversion
  
  public func inversionColor(duration: CGFloat, cornRadius: CGFloat? = nil, value: UIColor) { // .s1
    
    let v = UIView(frame: frame)
    v.backgroundColor = value.inverted
    v.layer.compositingFilter = "differenceBlendMode"
    addSubview(v)
  }
  
  
  // MARK: - Change Color
  
  private func buttonClickStyleDesignableBorderUpdate() {
    if let desFig = self as? ButtonClickStyleDesignView, desFig.brWidth != 0 {
      
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
  
  public func buttonClickStyleColorTouchDown(cornRadius: CGFloat? = nil, color: UIColor, alpha: CGFloat) { // .s1
    
    let from = color.withAlphaComponent(alpha)
    
    if let label = self as? UILabel {
      label.textColor = from
    }
    else if let desFig = self as? ButtonClickStyleDesignView,  desFig.brColor != .clear {
      buttonClickStyleDesignableBorderUpdate()

      layer.borderColor = from.cgColor
    } else {
      backgroundColor = from
    }
  }
  
  public func buttonClickStyleColor(duration: CGFloat, cornRadius: CGFloat? = nil, color: UIColor, alpha: CGFloat) { // .s1
    
//    return;
    
    let from = color.withAlphaComponent(alpha)
    let fromColor = from.cgColor
    
    //    if border {
    
    
    
    if let label = self as? UILabel {
      
      
      var to: UIColor = label.textColor
      if let desLab = self as? ButtonClickStyleDesignLabel, let grColor = desLab.grColor1 {
        to = grColor
      }
      
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
    }
    
    else if let desFig = self as? ButtonClickStyleDesignView, desFig.brColor != .clear {
      buttonClickStyleDesignableBorderUpdate()
    
      let to = desFig.brColor
      layer.borderColor = to.cgColor

      
      let animation2 = CABasicAnimation(keyPath: "borderColor")
      animation2.fromValue = from.cgColor
      animation2.toValue = to.cgColor
      animation2.duration = duration
      layer.add(animation2, forKey: "animationColor")
      layer.borderColor = to.cgColor
      
    } else {
      
      
      let toColor = UIColor.clear.cgColor
      
      let animation = CABasicAnimation(keyPath: "backgroundColor")
      animation.fromValue = fromColor
      animation.toValue = toColor
      animation.duration = duration
      layer.cornerRadius = radiusSearch(cornRadius)
      layer.add(animation, forKey: "animationColor")
      backgroundColor = .clear
      
    }
  }
  
  public func radiusSearch(_ cornRadius: CGFloat? = nil) -> CGFloat {
    if let r = cornRadius { return r }
    guard let mainView = self.superview else { return 0 }
    var radius = mainView.layer.cornerRadius
    if radius == 0 {
      for sv in mainView.subviews {
        if sv.layer.cornerRadius != 0 {
          radius = mainView.layer.cornerRadius
        }
        if let desFig = mainView as? ButtonClickStyleDesignView {
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
    return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a) 
  }
}
