
import UIKit

private let flatBorderTag = 62
private let flatTextTag = 63
private let flatImageTag = 64

extension UIView {
  
  // MARK: - Add Animation Color Flat
  
  func animationColorFlat(duration: CGFloat, cornRadius: CGFloat? = nil, visible: Bool, value: CGFloat,  color: UIColor? = nil) {
    
    guard let superview = self.superview else { return }
    
    if visible {
      
      
      
      
      superview.subviews.forEach { v1 in
        if v1.tag == flatImageTag || v1.tag == flatTextTag {
//          v1.tag = 0
          UIView.animate(withDuration: 0.1 , animations: {
            v1.alpha = 0
          }, completion: { fin in
            v1.removeFromSuperview()
          })

        }
      }
      
      if let desFig = self as? DesignableView {
        if let copyDesFig = superview.viewWithTag(flatBorderTag) {
          
//          if desFig.tag != flatBorderTag { return }
          
//          desFig.fillColor = desFig.brColor
//          desFig.brWidth = 0
//          desFig.brColor = UIColor.clear
          
          desFig.alpha = 1
          
          let subFigures = desFig.subviews.compactMap { $0 as? DesignableView }
          subFigures.forEach {
            if ($0.tag != flatBorderTag) && ($0.tag != flatTextTag) && ($0.tag != flatImageTag) {
              $0.alpha = 1.0
            }
          }
//
//          copyDesFig.tag = 0
          UIView.animate(withDuration: 0.1  , animations: {
            copyDesFig.alpha = 0
          }, completion: { fin in
            copyDesFig.removeFromSuperview()
          })
          
          
        }
      } else {
        
//        if self.tag != flatTextTag { return }
//        
//        let tintColor = self.tintColor
//        self.backgroundColor = tintColor
//        
//        self.layer.borderWidth = 0
//        self.layer.borderColor = UIColor.clear.cgColor
//        
//        self.tintColor = nil
//        
//        self.tag = 0
      }
      
    } else {
      
      
//      if self.tag == flatBorderTag { return }
      if let _ = superview.viewWithTag(flatBorderTag) { return }

      
      
      if let desFig = self as? DesignableView {
        
        let find = desFig.getFirstFindColorSubviews()
        let type: DesignableView.ColorType = find.typee
        let fill: UIColor? = color ?? find.color
//        if let fillColor = desFig.fillColor, fillColor != .clear {
//          fill = fillColor
//        } else if let grColor1 = desFig.grColor1, grColor1 != .clear {
//          fill = grColor1
//        } else if let backColor = backgroundColor, backColor != .clear {
//          fill = backColor
//        }

        if let fill = fill {
          
          if let copyDesFig = desFig.copy() as? DesignableView {
            copyDesFig.tag = flatBorderTag
            
            let val: CGFloat = value * 10
            
            copyDesFig.brWidth   = type == .fill ? val : 0
            copyDesFig.brColor   = type == .fill ? fill : .clear
            copyDesFig.fillColor = type == .fill ? .clear : fill
            copyDesFig.backgroundColor = UIColor.clear
            
            copyDesFig.grColor1 = nil
            copyDesFig.grColor2 = nil
            copyDesFig.grColor3 = nil
            copyDesFig.grColor4 = nil
            copyDesFig.layoutSubviews()
            
            superview.addSubview(copyDesFig)
          }

          desFig.alpha = 0.0

          let subFigures = desFig.subviews.compactMap { $0 as? DesignableView }
          subFigures.forEach {
            if ($0.tag != flatBorderTag) && ($0.tag != flatTextTag) && ($0.tag != flatImageTag) {
              $0.alpha = 0.0
            }
          }
          
          let imageVs = desFig.getAllImageViewSubviews()
          imageVs.forEach {
            
            let frame = $0.convert($0.bounds, to: superview)
            if let copyImgV = $0.copy() as? UIImageView {
              copyImgV.frame = frame
              copyImgV.tag = flatImageTag
//              copyImgV.backgroundColor = .red
              if let img = copyImgV.image?.withRenderingMode(.alwaysTemplate) {
                copyImgV.image = img
              }
              copyImgV.tintColor = type == .fill ? fill : fill.inverted
              superview.addSubview(copyImgV)
            }
          }

          let labels = desFig.getAllLabelsSubviews()
          labels.forEach {
//
            if let copyLabel = $0.copy() as? UILabel {
              copyLabel.tag = flatTextTag
              copyLabel.textColor = type == .fill ? fill : fill.inverted
              superview.addSubview(copyLabel)
            }
            
          }
          
          

//          desFig.tag = flatBorderTag
        }
      } else {
        
//        var fill: UIColor?
//        if let backColor = backgroundColor, backColor != .clear {
//          fill = backColor
//        }
//
//        if let fill = fill {
//          layer.borderColor = fill.cgColor
//          layer.borderWidth = 4
//          let saveBackColor = self.backgroundColor
//          self.tintColor = saveBackColor
//          backgroundColor = .clear
//        }
//
//        self.tag = flatTextTag
        
        
      }
      
    }
    //
  }
  
}

extension DesignableView {
  
  enum ColorType {
    case fill
    case border
    case gradient
  }
  
  
  
  func getFirstFindColorSubviews() -> (color: UIColor?, typee: ColorType) {
    if let fill = getFillColor()  {
      return (fill, .fill)
    }
    if let br = getBorderColor() {
        return (br, .border)
    }
    return (getFillColorSubviews(), .fill)
  }
  
  func getFillColorSubviews() -> UIColor? {
    var fill: UIColor? = self.getFillColor()
    if fill == nil {
      let subFigures = self.subviews.compactMap { $0 as? DesignableView }
      subFigures.forEach {
        if let color = $0.getFillColor(), fill == nil {
          fill = color
        }
      }
    }
    return fill
  }
  
  
  func getBorderColor() -> UIColor? {
    var br: UIColor?
    if self.brColor != .clear {
      br = self.brColor
    } else if let colorCg = self.layer.borderColor {
      let color = UIColor(cgColor: colorCg)
      if color != .clear {
        br = color
      }
    }
    return br
  }
  
  func getFillColor() -> UIColor?{
    var fill: UIColor?
    if let fillColor = self.fillColor, fillColor != .clear {
      fill = fillColor
    } else if let grColor1 = self.grColor1, grColor1 != .clear {
      fill = grColor1
    } else if let backColor = backgroundColor, backColor != .clear {
      fill = backColor
    }
    return fill
  }
  
  func getAllLabelsSubviews() -> [UILabel] {
    var labels = self.subviews.compactMap { $0 as? UILabel }
    self.subviews.forEach { v2 in
      labels += v2.subviews.compactMap { $0 as? UILabel }
      v2.subviews.forEach { v3 in
        labels += v3.subviews.compactMap { $0 as? UILabel }
      }
    }
    return labels
  }
  
  
  func getAllImageViewSubviews() -> [UIImageView] {
    var imageVs = self.subviews.compactMap { $0 as? UIImageView }
    self.subviews.forEach { v2 in
      imageVs += v2.subviews.compactMap { $0 as? UIImageView }
      v2.subviews.forEach { v3 in
        imageVs += v3.subviews.compactMap { $0 as? UIImageView }
      }
    }
    return imageVs
  }
  
}
