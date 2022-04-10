
import UIKit

public extension ButtonClick {
  
  typealias Emoji = (type: String, color: String, repeats: String, new: String)
  
  typealias Full = (base: String, name: String, emoji: Emoji, index: Int)
  
  typealias Closure = () -> ()
  
  @objc func invoke () {
    closureSleeve?()
  }
}


public extension UIControl {
  func click(for controlEvents: UIControl.Event = .touchUpInside,
             _ closure: @escaping ButtonClick.Closure) {
    let sleeve = ButtonClick(closure)
    addTarget(sleeve, action: #selector(ButtonClick.invoke), for: controlEvents)
    objc_setAssociatedObject(self,
                             String(format: "[%d]", arc4random()),
                             sleeve,
                             objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
}
