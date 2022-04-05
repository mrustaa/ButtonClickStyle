
import UIKit

extension UIView {
  
  // MARK: - Press
  
  func press(duration: CGFloat, cornRadius: CGFloat? = nil, value: CGFloat, shadow: Bool, visible: Bool) {
    if visible {
      animate(duration: duration, view: self, transform: .identity)
      if shadow {
        updateLayerGray(with: [self], superView: false, cornRadius: cornRadius,  visible: true, value: value, duration: duration)
      }
    } else {
      
      if shadow {
        let to = 1.0 - (value * 0.05)
        animate(duration: duration, view: self, transform: .identity.scaledBy(x: to, y: to))
        updateLayerGray(with: [self], superView: false, cornRadius: cornRadius, visible: false, value: value / 3 , duration: duration / 3)
      } else {
        let to = 0.45 + ((value)  * 5.0)
        animate(duration: duration, view: self,  transform: .identity.translatedBy(x: 0, y: to))
        
      }
    }
  }
}
