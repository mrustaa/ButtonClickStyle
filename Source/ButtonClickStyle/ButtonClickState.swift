//
//  BtnCellState.swift
//  ButtonCustomButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 26.03.2022.
//

import UIKit

extension ButtonClick {
  
  public struct State: Equatable {
    var titleText: String?
    var allSubviews: Bool = true
    var animationType: Int?
    var animationTypeValue: CGFloat?
    var animationDuration: CGFloat?
    var new: Bool = false
    var color: UIColor?
    var startClick: Bool = false
    var debugButtonShow: Bool = false
    var addBackgrondColor: Bool = true
  }
  
}
