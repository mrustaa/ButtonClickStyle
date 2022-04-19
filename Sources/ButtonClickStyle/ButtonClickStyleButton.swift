//
//  ButtonClickStyleButton.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 19.04.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

open class ButtonClickStyleButton: UIButton {
  
  public var click: ButtonClick.ClosureEvent?
  
  // MARK: - Initialize
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  public init(
    frame: CGRect,
    click: ButtonClick.ClosureEvent? = nil
  ) {
    super.init(frame: frame)
    self.click = click
  }
}
