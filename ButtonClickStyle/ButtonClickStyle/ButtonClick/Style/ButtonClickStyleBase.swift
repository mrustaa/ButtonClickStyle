//
//  ButtonClick+StyleBase.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 10.04.2022.
//

import UIKit

extension ButtonClick {
  
  enum StyleBase: String, CaseIterable {
    case hide = "Hide"
    case move = "Move"
    case add = "Add"
    case addHide = "Add & Hide"
    case android = "TapGesture.Pulse"
    case none = "❌"
  }
}
