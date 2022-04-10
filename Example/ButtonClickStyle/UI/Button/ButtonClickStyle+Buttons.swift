//
//  ButtonClickStyle+Buttons.swift
//  ButtonClickStyle_Example
//
//  Created by Рустам Мотыгуллин on 11.04.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

extension ButtonClick {
  
  //MARK: - Style
  
  public enum Buttons: String, CaseIterable {
    case JustPink
    case NoShadow
    case Blue
    case BuyNow
    case Download
    case Delete
    case Search
    case Subscribe
    case Firefox
    case Google
    case GrButton
    case Neomorphism
    case TestButton
    case Green
    case TestRandom
    case Test3Squares
    
    public static var allName: [String]      = ButtonClick.Buttons.allCases.map { $0.rawValue }
    public static var allCases: [ButtonClick.Buttons] = [
      .JustPink,
      .NoShadow,
      .Blue,
      .BuyNow,
      .Download,
      .Delete,
      .Search,
      .Subscribe,
      .Firefox,
      .Google,
      .GrButton,
      .Neomorphism,
      .TestButton,
      .Green,
      .TestRandom,
      .Test3Squares
    ]
    
    public static var shortNames: [String]      = ButtonClick.Buttons.allCases.map { $0.rawValue }
    public static var shortCases: [ButtonClick.Buttons] = [
      .JustPink,
      .NoShadow,
      .Blue,
      .BuyNow,
      .Download,
      .Delete,
      .Search,
      .Subscribe,
      .Firefox,
      .Google,
      .GrButton,
      .Neomorphism,
      .TestButton,
      .Green,
    ]
  }
}



