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
  var animationDuration: CGFloat?
  var new: Bool = false
  var color: UIColor?
  var addBackgrondColor: Bool = true
//  var startClick: Bool = false
//  var buttonColor: Bool = false
}
