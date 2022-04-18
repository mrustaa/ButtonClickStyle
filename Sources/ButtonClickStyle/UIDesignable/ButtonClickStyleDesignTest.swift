//
//  ButtonClickStyleDesignTest.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 17.04.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable
public class ButtonClickStyleDesignTest: UIView {
  
  @IBInspectable var cornerRadius: CGFloat = 0.0
  @IBInspectable var fillColor: UIColor?
  
  //MARK: - Draw
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    backgroundColor = .clear
    
    layer.backgroundColor = fillColor?.cgColor
    
//    let bezier = rectangle(rect: bounds, radius: cornerRadius)
//    addFill(bezier: bezier)
    layer.cornerRadius = cornerRadius
  }
  
  public override func layoutSubviews() {
    
    backgroundColor = .clear
  }
  
}
