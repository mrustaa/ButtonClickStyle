//
//  BtnView.swift
//  ButtonCustomButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 26.03.2022.
//

import UIKit

class BtnView: XibView {
  
  // MARK: Properties
  
  var state: BtnCellState?
  var animation: ButtonClickStyleView?
  
  func fill(state: BtnCellState?) {
    
    guard let state = state else { return }
    self.state = state
  }
  
  // override func awakeFromNib() { }
}
