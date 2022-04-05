//
//  ButtonClick.Style.swift
//  ButtonCustomButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 29.03.2022.
//

import UIKit

private let vDef: CGFloat = 0.5

extension ButtonClick {
  
  //MARK: - Style
  
  enum StyleEasy: Int, CaseIterable {
    case alpha
    case flash
    case shadow
    case shadowColor
    case color
    case colorFlat
    case pulsateNew
    case pulsate
    case press
    case shake
    case shakeNew
    case androidClickable
    case androidClickableDark
  }
  
  
  enum Style: CaseIterable {
    case alpha(           _ alpha: CGFloat = vDef) // 0.5                       // HIDE Alpha
    case flash(           _ alpha: CGFloat = vDef)                              // HIDE Flash More
    case shadow(          _ alpha: CGFloat = vDef, color: UIColor? = nil) // 0.1845 add black shadow   // ADD  Shadow
    case color(           _ alpha: CGFloat = vDef, color: UIColor = .red)       // ADD  Color
    case colorFlat(       _ alpha: CGFloat = vDef, color: UIColor? = nil)       // ADD  Color
    case pulsate(         _ power: CGFloat = vDef, new:  Bool = false)          // MOVE Pulsate
    case press(           _ power: CGFloat = vDef)                              // MOVE Press
    case shake(           _ power: CGFloat = vDef, new:  Bool = false)          // MOVE Shake
    case androidClickable(_ alpha: CGFloat = vDef, dark: Bool = false)          // ADD  Android Clickable
    
    case test_Hide(_ alpha: CGFloat? = nil)
    
    //MARK: All Cases, Indxs & Names
    
    static var allIndx:  [Int]     = ButtonClick.Style.allCases.map { $0.indx() }
    static var allName:  [String]  = ButtonClick.Style.allCases.map { $0.str()  }
    static var allCases: [ButtonClick.Style] = [
      .alpha(),
      .flash(),
      .shadow(),
      .shadow(vDef, color: .random()),
      .color(),
      .colorFlat(),
      .pulsate(new: true),
      .pulsate(),
      .press(),
      .shake(),
      .shake(new: true),
      .androidClickable(),
      .androidClickable(dark: true),
    ]
    
    func typeEasy() -> StyleEasy {
      StyleEasy.allCases[indx()] 
    }
    
    //MARK: String
    
    func str() -> String {
      switch self {
      case .alpha(_):                      return         "hide  .alpha"
      case .flash(_):                      return         "hides .flash"
      case .shadow(_, let color):   return color == nil ? "add  .shadow"
                                                        : "add  .shadow color"
      case .color(_, _):                   return         "add  .color"
      case .colorFlat(_, _):               return         "add  .color flat" // border text
      case .pulsate(_, let new):           return new   ? "move .pulsate new"
                                                        : "move .pulsate"
      case .press(_):                      return         "move .press"
      case .shake(_, let new):             return new   ? "move .shake   new"
                                                        : "move .shake"
      case .androidClickable(_, let dark): return dark  ? "add  .androidClickable dark"
                                                        : "add  .androidClickable ligth"
      case .test_Hide(_): return "test"
      }
    }
    
    //MARK: Full
    
    func full() -> String {
      return "[\(indx())] \(str())"
    }
    
    //MARK: Index
    
    func indx() -> Int {
      switch self {
      case .alpha(_):                      return         0
      case .flash(_):                      return         1
      case .shadow(_, let color):   return color == nil ? 2
                                                        : 3
      case .color(_, _):                   return         4
      case .colorFlat(_, _):               return         5
      case .pulsate(_, let new):           return  new ?  6
                                                       :  7
      case .press(_):                      return         8
      case .shake(_, let new):             return  new ?  9
                                                       : 10
      case .androidClickable(_, let dark): return dark ? 11
                                                       : 12
      case .test_Hide(_):                         return 13
//      default: return -1
      }
    }
    
    // MARK: Default Duration
    
    func defaultDuration() -> CGFloat {
      switch self {
      case .alpha(_):                return 0.3
      case .shadow(_, let color):    return color == nil ? 0.3 : 0.3              // .ms300
      case .pulsate(_, let new):     return new ? 0.4 : 0.2  // .ms200
      case .press(_):                return 0.25
      case .flash(_):                return 0.2              // .ms200
      case .shake(_, let new):       return new ? 0.6 : 0.05 // .ms50
      case .color(_, _):             return 0.3              // .ms300
      case .colorFlat(_, _):         return 0.3              // .ms300
      case .androidClickable(_, _):  return 1.0              // .s1
      case .test_Hide(_): return 1.0
//      default: return 0.3
      }
    }
    
    // MARK: Default Value ClickStyle
    
    static func getClick(state: BtnCellState) -> ButtonClick.Style {
      getClick(
        style: state.animationType ?? 0,
        value: state.animationTypeValue,
        color: state.color
      )
    }
    
    static func getClick(style: Int, value: CGFloat?, color: UIColor?) -> ButtonClick.Style {
      
      let a = value
      let v: CGFloat = a ?? 0.5
      let style: ButtonClick.Style = {
        switch style {
        case 0: return .alpha(v)
        case 1: return .flash(v)
        case 2: return .shadow(a ?? 0.28, color: nil)
        case 3: return .shadow(a ?? 0.28, color: color ?? UIColor.random())
        case 4: return .color(v, color: color ?? UIColor.random())
        case 5: return .colorFlat(v, color: color)
        case 6: return .pulsate(v, new: true)
        case 7: return .pulsate(v, new: false)
        case 8: return .press(v)
        case 9: return .shake(a ?? 0.45, new: false)
        case 10:  return .shake(a ?? 0.15, new: true)
        case 11: return .androidClickable(v, dark: false)
        case 12: return .androidClickable(v, dark: true)
        default: return .alpha(v)
        }
      }()
      return style
    }
    
  }
  
}

