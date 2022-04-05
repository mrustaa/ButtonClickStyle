//
//  BtnCellState.swift
//  ButtonCustomButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 26.03.2022.
//

import UIKit

struct BtnCellState: Equatable {
  var titleText: String?
  var allSubviews: Bool = true
  var animationType: Int?
  var animationTypeValue: CGFloat?
  var startClick: Bool = true
  var new: Bool = false
  var color: UIColor?
  var addBackgrondColor: Bool = true
  var buttonColor: Bool = false
}
