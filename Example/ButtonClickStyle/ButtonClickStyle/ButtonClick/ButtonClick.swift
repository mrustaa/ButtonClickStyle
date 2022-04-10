

import UIKit

public class ButtonClick {
  
  var button: UIButton?
  var closureSleeve: ButtonClick.Closure?
  
  init(_ closure: @escaping ButtonClick.Closure) {
    self.closureSleeve = closure
  }
  
}

