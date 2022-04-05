

import UIKit

class ButtonClick {
  
  var button: UIButton?
  
  init(_ closure: @escaping ButtonClick.Closure) {
    self.closureSleeve = closure
  }
  
  typealias Closure = () -> ()
  
  let closureSleeve: ButtonClick.Closure?
  @objc func invoke () {
    closureSleeve?()
  }
}


extension UIControl {
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

