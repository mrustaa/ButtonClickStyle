//
//  BtnView.swift
//  ButtonCustomButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 26.03.2022.
//

import UIKit

class BtnView: XibView {
  
  // MARK: Properties
  
  var state: ButtonClick.State?
  var btnClickStyleView: ButtonClickStyleView?
  
  func fill(state: ButtonClick.State?) {
    
    guard let state = state else { return }
    self.state = state
  }
  
}
