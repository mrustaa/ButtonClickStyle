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
    var animationStyle: _Style?
    var animationTypeValue: CGFloat?
    var animationDuration: CGFloat?
    var new: Bool = false
    var color: UIColor?
    var startClick: Bool = false
    var debugButtonShow: Bool = false
    var addBackgrondColor: Bool = true
    
    public init(
      titleText: String? = nil,
      allSubviews: Bool = true,
      animationType: Int? = nil,
      animationStyle: _Style? = nil,
      animationTypeValue: CGFloat? = nil,
      animationDuration: CGFloat? = nil,
      new: Bool = false,
      color: UIColor? = nil,
      startClick: Bool = false,
      debugButtonShow: Bool = false,
      addBackgrondColor: Bool = true
    ) {
      self.titleText = titleText
      self.allSubviews = allSubviews
      self.animationType = animationType
      self.animationStyle = animationStyle
      self.animationTypeValue = animationTypeValue
      self.animationDuration = animationDuration
      self.new = new
      self.color = color
      self.startClick = startClick
      self.debugButtonShow = debugButtonShow
      self.addBackgrondColor = addBackgrondColor
    }
  }
}
