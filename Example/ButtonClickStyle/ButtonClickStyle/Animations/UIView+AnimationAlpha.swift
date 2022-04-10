

import UIKit

public extension UIView {
  
  // MARK: - Alpha
  
  func buttonClickStyleAlpha(with views: [UIView], visible: Bool, value: CGFloat, duration: CGFloat?) {
    
    var alpha: CGFloat = 1.0
    if visible != true {
      alpha = value
    }
    
    if let duration = duration {
      UIView.animate(withDuration: duration, animations: {
        for view in views {
          view.alpha = alpha
        }
      })
    } else {
      for view in views {
        view.alpha = alpha
      }
    }
  }
  
}
