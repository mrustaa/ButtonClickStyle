
import UIKit

extension ButtonClick {
  
  public typealias Emoji = (type: String, color: String, repeats: String, new: String)
  public typealias Full = (base: String, name: String, emoji: Emoji, index: Int)
  public typealias Closure = () -> ()
  public typealias ClosureEvent = (_ event: UIControl.Event) -> ()
  
  
  @objc public func invoke() {
    closureSleeve?()
  }
}


extension UIControl {
  public func click(for controlEvents: UIControl.Event = .touchUpInside,
             _ closure: @escaping ButtonClick.Closure) {
    let sleeve = ButtonClick(closure)
    addTarget(sleeve, action: #selector(ButtonClick.invoke), for: controlEvents)
    objc_setAssociatedObject(self,
                             String(format: "[%d]", arc4random()),
                             sleeve,
                             objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
}
