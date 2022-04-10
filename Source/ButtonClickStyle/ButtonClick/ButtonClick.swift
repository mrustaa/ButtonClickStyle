

import UIKit

open class ButtonClick {
  
  public var button: UIButton?
  public var closureSleeve: ButtonClick.Closure?
  
  public init(_ closure: @escaping ButtonClick.Closure) {
    self.closureSleeve = closure
  }
  
}

