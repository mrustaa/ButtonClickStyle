
import UIKit

class StoryboardController: UIViewController {
  
  class func instantiate() -> UIViewController {
    return fromStoryboardController()
  }
  
  class func fromStoryboardController() -> UIViewController {
    let className = String(describing: self)
    let storyboard = UIStoryboard.init(name: className, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: className)
  }
}

extension StoryboardController: UIGestureRecognizerDelegate {
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
