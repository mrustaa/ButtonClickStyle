
import UIKit

private let shTag = 31
private let shColor: UIColor = .init(red: 10.0 / 255.0, green: 13.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)

extension UIView {
  
  // MARK: - Layer Gray
  
  private func buttonClickStyleGetShadowView(superView: Bool) -> UIView? {
    guard let mainView = (superView ? self.superview : self) else { return nil }
    
    var shadowView: UIView?
    for v in mainView.subviews {
      if v.tag == shTag {
        shadowView = v
      }
    }
    return shadowView
  }
  
  // MARK: - Add Shadow View
  
  func buttonClickStyleAddShadowView(with views: [UIView],
                     superView: Bool = false,
                     shadowColor: UIColor?,
                     value: CGFloat = 1.0
  ) -> UIView? {
    
    guard let mainView = (superView ? self.superview : self) else { return nil }
    
    mainView.clipsToBounds = false
    
    if mainView.viewWithTag(shTag) != nil { return nil }
    
    let shadowView = UIView(frame: self.bounds)// mainView.bounds)
    shadowView.tag = shTag
    shadowView.clipsToBounds = false
    var wMax: CGFloat = 0
    var hMax: CGFloat = 0
    
    let shadowContentView = UIView(frame: self.bounds)
    shadowContentView.alpha = value
    shadowContentView.clipsToBounds = false
    shadowView.addSubview(shadowContentView)
    
    views.forEach {
      let clip = $0.superview?.clipsToBounds ?? false
      
      
      if wMax < $0.right  { wMax = $0.right  }
      if hMax < $0.bottom { hMax = $0.bottom }
      
      let frame = $0.convert($0.bounds, to: mainView)
      let imgBtn = UIButton(frame: frame)
      let image: UIImage!
      
      let tinttColor = shadowColor ?? shColor
      
      $0.superview?.clipsToBounds = false
      
        image = $0.asImage().withRenderingMode(.alwaysTemplate)
      $0.superview?.clipsToBounds = clip
        
        imgBtn.setImage(image, for: .normal)
        imgBtn.tintColor = tinttColor
        
      shadowContentView.addSubview(imgBtn)
    }
    shadowView.width = wMax
    shadowView.height = hMax
    
    mainView.addSubview(shadowView)
    
    return shadowView
  }
  
  func buttonClickStyleShadow(with views: [UIView], superView: Bool = true, color: UIColor? = nil, cornRadius: CGFloat? = nil, visible: Bool, value: CGFloat, duration: CGFloat?) {
    
    if visible {
      
      guard let shadowView = buttonClickStyleGetShadowView(superView: superView) else { return }
      
      if let duration = duration {
        UIView.animate(withDuration: duration,
                       animations: {
          shadowView.alpha = 0
        },
                       completion: { fin in
          shadowView.removeFromSuperview()
        }
        )
      } else {
        shadowView.alpha = 0
        shadowView.removeFromSuperview()
      }
      
      
    } else {
      
      guard let shadowView = buttonClickStyleAddShadowView(with: views, superView: superView, shadowColor: color, value: value) else { return }
      
      shadowView.alpha = ((duration == nil) ? 1 : 0)
      if let duration = duration {
        if duration == .zero {
          shadowView.alpha = 1
        } else {
          UIView.animate(withDuration: duration, animations: {
            shadowView.alpha = 1
          })
        }
      }
      
    }
  }
}

//MARK: - extensions

extension UIView {
  func asImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    return renderer.image { rendererContext in
      layer.render(in: rendererContext.cgContext)
    }
  }
}

