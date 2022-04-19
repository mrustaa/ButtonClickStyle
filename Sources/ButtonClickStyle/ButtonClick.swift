

import UIKit

open class ButtonClick {
  
  public var closureSleeve: ButtonClick.Closure?
  
  public init(_ closure: @escaping ButtonClick.Closure) {
    self.closureSleeve = closure
  }
  
}

