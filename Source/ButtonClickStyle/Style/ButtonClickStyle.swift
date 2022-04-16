//
//  ButtonClick.Style.swift
//  ButtonCustomButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 29.03.2022.
//

import UIKit

public let vDef: CGFloat = 0.5

extension ButtonClick {
  
  //MARK: - Style
  
  public enum Style: CaseIterable {
    case alpha(           _ alpha: CGFloat = vDef)                              // HIDE Alpha
    case flash(           _ alpha: CGFloat = vDef)                              // HIDE Flash More
    case shadow(          _ alpha: CGFloat = vDef, color: UIColor? = nil)       // 0.1845 add black shadow   // ADD  Shadow
    case color(           _ alpha: CGFloat = vDef, color: UIColor = .red)       // ADD  Color
    case colorFlat(       _ alpha: CGFloat = vDef, color: UIColor? = nil)       // ADD  Color
    case press(           _ power: CGFloat = vDef)                              // MOVE Press
    case pulsate(         _ power: CGFloat = vDef, new:  Bool = false)          // MOVE Pulsate
    case shake(           _ power: CGFloat = vDef, new:  Bool = false)          // MOVE Shake
    case androidClickable(_ alpha: CGFloat = vDef, color: UIColor? = nil)       // ADD  Android Clickable
    case fave(            _ power: CGFloat = vDef, color: UIColor? = nil)       //
    case glare(           _ alpha: CGFloat = vDef, color: UIColor? = nil)       //
    
    
    //MARK: All Cases, Indxs & Names
    
    public static var allIndx: [Int]         = ButtonClick.Style.allCases.map { $0.indx() }
    public static var allNameFull: [Full]    = ButtonClick.Style.allCases.map { $0.nameFull() }
    public static var allName: [String]      = ButtonClick.Style.allCases.map { $0.name()  }
    public static var allCases: [ButtonClick.Style] = [
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
      .androidClickable(color: .random()),
      .fave(vDef, color: .random()),
      .glare(vDef, color: .random()),
    ]
    
    public func typeEasy() -> _Style {
      _Style.allCases[indx()] 
    }
    
    //MARK: String
    
    public func nameFull() -> Full {
      return (baseStyle().rawValue, str(), emoji(), indx())
    }
    
    public func name(full: Bool = false) -> String {
      return "\(full ? baseStyle().rawValue : "") \(str())"
    }
    
    public func str() -> String {
      switch self {
      case .alpha(_):                       return                "Alpha"
      case .flash(_):                       return                "Alpha Flash"
      case .shadow(_, let color):           return color == nil ? "Shadow "
                                                                : "Shadow Color"
      case .color(_, _):                    return                "Color Old"
      case .colorFlat(_, _):                return                "Color Flat" // border text
      case .press(_):                       return                "Press"
      case .pulsate(_, let new):            return new          ? "Pulsate New"
                                                                : "Pulsate"
      case .shake(_, let new):              return new          ? "Shake New"
                                                                : "Shake"
      case .androidClickable(_, let color): return color == nil ? "AndroidClickable"
                                                                : "AndroidClickable Color"
      case .fave(_,_):                      return                "Fave"
      case .glare(_,_):                     return                "Glare"
      }
    }
    
    // MARK: Base Style
    
    public func baseStyle() -> StyleBase {
      switch self {
      case .alpha(_), .flash(_): return .hide
      case .shadow(_,_), .color(_,_), .colorFlat(_,_): return .add
      case .pulsate(_,_), .press(_), .shake(_,_): return .move
      case .androidClickable(_,_): return .tapGesture
      case .fave(_,_): return .tapGesture
      case .glare(_,_): return .loading
      }
    }
    
    //MARK: Full
    
    public func full() -> String {
      return "[\(indx())] \(str())"
    }
    
    //MARK: Index
    
    public func indx() -> Int {
      switch self {
      case .alpha(_):                       return                 0
      case .flash(_):                       return                 1
      case .shadow(_, let color):           return color == nil ?  2
                                                                :  3
      case .color(_, _):                    return                 4
      case .colorFlat(_, _):                return                 5
      case .pulsate(_, let new):            return  new         ?  6
                                                                :  7
      case .press(_):                       return                 8
      case .shake(_, let new):              return  new         ?  9
                                                                : 10
      case .androidClickable(_, let color): return color == nil ? 11
                                                                : 12
      case .fave(_, _):                     return                13
      case .glare(_, _):                    return                14
      }
    }
    
    // MARK: Default Duration
    
    public func defaultDuration() -> CGFloat {
      switch self {
      case .alpha(_):                return 0.3
      case .shadow(_, let color):    return color == nil ? 0.3 : 0.3 // .ms300
      case .pulsate(_, let new):     return new ? 0.4 : 0.2  // .ms200
      case .press(_):                return 0.25
      case .flash(_):                return 0.2              // .ms200
      case .shake(_, let new):       return new ? 0.6 : 0.05 // .ms50
      case .color(_, _):             return 0.3              // .ms300
      case .colorFlat(_, _):         return 0.3              // .ms300
      case .androidClickable(_, _):  return 1.0              // .s1
      case .fave(_, _):              return 0.4
      case .glare(_, _):             return 1.0
      }
    }
    
    // MARK: Default Value ClickStyle
    
    static func getClick(state: ButtonClick.State) -> ButtonClick.Style {
      getClick(
        style: state.animationType ?? 0,
        value: state.animationTypeValue,
        color: state.color
      )
    }
    
    static func getClick(style: Int, value: CGFloat?, color: UIColor?) -> ButtonClick.Style {
      let c: UIColor = color ?? UIColor.random()
      let a = value
      let v: CGFloat = a ?? 0.5
      let style: ButtonClick.Style = {
        switch style {
        case 0: return .alpha(v)
        case 1: return .flash(v)
        case 2: return .shadow(a ?? 0.28, color: nil)
        case 3: return .shadow(a ?? 0.28, color: c)
        case 4: return .color(v, color: c)
        case 5: return .colorFlat(v, color: color)
        case 6: return .pulsate(v, new: true)
        case 7: return .pulsate(v, new: false)
        case 8: return .press(v)
        case 9: return .shake(a ?? 0.45, new: false)
        case 10: return .shake(a ?? 0.15, new: true)
        case 11: return .androidClickable(v, color: nil)
        case 12: return .androidClickable(v, color: c)
        case 13: return .fave(v, color: c)
        case 14: return .glare(v, color: color)
        default: return .alpha(v)
        }
      }()
      return style
    }
    
  }
  
}

