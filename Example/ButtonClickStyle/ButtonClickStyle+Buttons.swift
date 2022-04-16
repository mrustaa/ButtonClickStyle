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
    
    
    public func name() -> String {
      switch self {
      case .JustPink:     return "JustPink"
      case .NoShadow:     return "No shadow"
      case .Blue:         return "Blue"
      case .BuyNow:       return "BuyNow"
      case .Download:     return "Download"
      case .Delete:       return "Delete"
      case .Search:       return "Search"
      case .Subscribe:    return "Subscribe"
      case .Firefox:      return "Firefox"
      case .Google:       return "Google"
      case .GrButton:     return "Gr Button"
      case .Neomorphism:  return "Neomorphism"
      case .TestButton:   return "Test Button"
      case .Green:        return "Green"
      case .TestRandom:   return "Test Random"
      case .Test3Squares: return "Test 3 Squares"
      }
    }
    
    static func newBtnView(_ type: ButtonClick.Buttons) -> BtnView? {
      var c: BtnView
      switch type {
      case .JustPink:     c = JustPinkButtonView()
      case .NoShadow:     c = JustPinkButtonView()
      case .Blue:         c = BlueButtonView()
      case .BuyNow:       c = BuyNowButtonView()
      case .Download:     c = DownloadButtonView()
      case .Delete:       c = DeleteButtonView()
      case .Search:       c = SearchButtonView()
      case .Subscribe:    c = SubscribeButtonView()
      case .Firefox:      c = FirefoxButtonView()
      case .Google:       c = GoogleButtonView()
      case .GrButton:     c = GradientBlueBasicButtonView()
      case .Neomorphism:  c = NeomorphismButtonView()
      case .TestButton:   c = TestDemoGradientButtonView()
      case .Green:        c = BorderGreenDarkButtonView()
      case .Test3Squares: c = TestDemoSquaresButtonView()
      case .TestRandom:   c = TestDemoBlurButtonView()
      }
      return c
    }
    
    
    static func newBtnView(_ indx: Int) -> BtnView? {
      var c: BtnView
      switch indx {
      case  0:     c = JustPinkButtonView()
      case  1:     c = JustPinkButtonView()
      case  2:         c = BlueButtonView()
      case  3:       c = BuyNowButtonView()
      case  4:     c = DownloadButtonView()
      case  5:       c = DeleteButtonView()
      case  6:       c = SearchButtonView()
      case  7:    c = SubscribeButtonView()
      case  8:      c = FirefoxButtonView()
      case  9:       c = GoogleButtonView()
      case 10:     c = GradientBlueBasicButtonView()
      case 11:  c = NeomorphismButtonView()
      case 12:   c = TestDemoGradientButtonView()
      case 13:        c = BorderGreenDarkButtonView()
      case 14: c = TestDemoSquaresButtonView()
      case 15:   c = TestDemoBlurButtonView()
      default:
        c = JustPinkButtonView()
      }
      return c
    }
    
    public func index() -> Int {
      switch self {
      case .JustPink:     return  0
      case .NoShadow:     return  1
      case .Blue:         return  2
      case .BuyNow:       return  3
      case .Download:     return  4
      case .Delete:       return  5
      case .Search:       return  6
      case .Subscribe:    return  7
      case .Firefox:      return  8
      case .Google:       return  9
      case .GrButton:     return 10
      case .Neomorphism:  return 11
      case .TestButton:   return 12
      case .Green:        return 13
      case .Test3Squares: return 14
      case .TestRandom:   return 15
      }
    }
    
    public func type(index: Int) -> Buttons {
      switch index {
      case  0: return .JustPink
      case  1: return .NoShadow
      case  2: return .Blue
      case  3: return .BuyNow
      case  4: return .Download
      case  5: return .Delete
      case  6: return .Search
      case  7: return .Subscribe
      case  8: return .Firefox
      case  9: return .Google
      case 10: return .GrButton
      case 11: return .Neomorphism
      case 12: return .TestButton
      case 13: return .Green
      case 14: return .Test3Squares
      case 15: return .TestRandom
      default:
        return .JustPink
      }
    }
    
    public static var allNameIndx: [Int] = ButtonClick.Buttons.allCases.map { $0.index() }
    public static var allNameFull: [String] = ButtonClick.Buttons.allCases.map { $0.name() }
    public static var allName: [String] = ButtonClick.Buttons.allCases.map { $0.rawValue }
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
      .Test3Squares,
      .TestRandom
    ]
    
    public static var allCases3: [ButtonClick.Buttons] = [
      .JustPink,
      .NoShadow,
      .Blue,
      .Test3Squares,
      .TestRandom
    ]
    
    public static var shortNames: [String] = ButtonClick.Buttons.allCases.map { $0.rawValue }
  }
}



