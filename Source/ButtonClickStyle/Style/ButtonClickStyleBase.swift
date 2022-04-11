//
//  ButtonClick+StyleBase.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 10.04.2022.
//

import UIKit

extension ButtonClick {
  
  public enum StyleBase: String, CaseIterable {
    case hide = "Hide"
    case move = "Move"
    case add = "Add"
    case addHide = "Add & Hide"
    case tapGesture = "TapGesture.Pulse"
    case loading = "Loading"
    case none = "❌"
  }
}
