//
//  ButtonClickStyleView.swift
//  ButtonLayersButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 09.03.2022.
//

import UIKit

// MARK: - ButtonClickStyleView

@IBDesignable
public class ButtonClickStyleView: UIView {
  
  @IBInspectable var animType: Int = 0
  @IBInspectable var animValue: CGFloat = 0.0
  @IBInspectable var animDuration: CGFloat = 0.0
  @IBInspectable var allSubviews: Bool = true
  
  var addViews: [UIView]?
          
  var state: ButtonClick.State?
  
  private var style: ButtonClick.Style = .alpha(0.5)
  private let debugPrint: Bool = true
  private var setupDone = false
  
  
  var cornerRadius: CGFloat = 0.0
  
  
//  var frontView: UIView?
  var button: UIButton?
  
  
  // MARK: - Initialize
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    updateSubviews()
    
    if debugPrint { print(" ------------------------------------------") }
    if debugPrint { print(" ButtonClickStyleView 👹 init coder 👹 \(self) ") }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    if debugPrint { print(" ------------------------------------------") }
    if debugPrint { print(" ButtonClickStyleView 🥶 init frame 🥶 \(self) ") }
  }
  
  
  public init(
    state: ButtonClick.State,
    frame: CGRect,
    radius: CGFloat = 0.0,
    addViews: [UIView]? = nil
  ) {
    
    super.init(frame: frame)
    
    var state = state
    if state.animationType == ButtonClick._Style.colorFlat.rawValue {
      state.allSubviews = false
    }
    
    self.state = state
    self.cornerRadius = radius
    self.layer.cornerRadius = radius
    self.allSubviews = state.allSubviews
    self.animType = state.animationType ?? 0
    self.addViews = addViews
    
    
    if debugPrint { print(" ------------------------------------------") }
    if debugPrint { print(" ButtonClickStyleView 🥶 init (STATE frame radius addViews) 🥶 \(self) ") }
    
  }
  
  func createState() {
    
    if self.state == nil {
      var allSubviews = self.allSubviews
      if animType == ButtonClick._Style.colorFlat.rawValue {
        allSubviews = false
      }
      
      let animVal: CGFloat? =  animValue    != 0.0 ? animValue    : nil
      let animDur: CGFloat? =  animDuration != 0.0 ? animDuration : nil
      
      self.state = .init(
        allSubviews: allSubviews,
        animationType: animType,
        animationTypeValue: animVal,
        animationDuration: animDur
      )
    }
  }
  
  // MARK: - Layout subViews Update
  
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    if debugPrint { print(" ButtonClickStyleView 😢Designable💙 draw(_ rect: CGRect)  \(self) ")}
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if debugPrint { print(" ButtonClickStyleView 😢Designable💚 layoutSubviews  \(self) ")}
    createState()
    updateSubviews()
  }
  
  // MARK: - Update Subviews
  
  public func updateSubviews() {
    if debugPrint { print(" ButtonClickStyleView 🟨 updateSubviews 🟨🥷🏻 setupDone \(setupDone ? "❌" : "✅") \(self) ")}
    
    
    if setupDone { return }
    guard let state = state else { return }
    
    self.style = ButtonClick.Style.getClick(state: state)
    
    var onlyButtonReturn = true
    switch style.typeEasy() {
    case .color, .androidClickable, .androidClickableDark: onlyButtonReturn = false
    default: break
    }
    
    if button == nil { createButton() }
    
    if onlyButtonReturn {
      let nviews = getViews()
      if nviews.count == 1 {
        if nviews[0] is UIButton {
          if debugPrint { print(" ButtonClickStyleView 🅿️ nviews ONLY BUTTON 🅿️‼️ return ")}
          return
        }
      }
    }
    
    setAnimation(style: style)
      
    updateStartClick()
    
    setupDone = true
  }
  
  func updateStartClick() {
    if self.state?.startClick ?? false {
      self.state?.startClick = false
      
      guard let state = state else { return }
      
      self.style = ButtonClick.Style.getClick(state: state)
      let nviews = getViews()
      button?.onClick(views: nviews, radius: cornerRadius, style: style, duration: state.animationDuration)
    }
    
  }
  
  public func update(animationType: Int, allSubviews: Bool = true) {
    button?.removeFromSuperview()
    button = nil
    
    self.state?.animationType = animationType
    self.state?.allSubviews = allSubviews
    
    self.animType = animationType
    self.allSubviews = allSubviews
    
    setupDone = false
//    button?.removeTarget(nil, action: nil, for: .allEvents)
    updateSubviews()
    if let btn = button {
//      btn.backgroundColor = .red.withAlphaComponent(0.25)
      btn.isUserInteractionEnabled = true
    }
  }
  
  
  // MARK: - Set Animation Style
  
  public func setAnimation(style: ButtonClick.Style, views: [UIView]? = nil) {
    //    updateSubviews()
    
    layer.cornerRadius = cornerRadius
    
    let nviews = getViews(views: views)
    
    if debugPrint { print(" ButtonClickStyleView 🅿️ nviews 🅿️🥷🏻 \(nviews) ")}
    button?.addClickStyle(views: nviews, radius: cornerRadius, style: style, callback: { event in
      if event == .touchUpInside {
        
      }
    })
    if debugPrint { print(" ButtonClickStyleView Ⓜ️ self.subviews Ⓜ️🥷🏻 \(self.subviews) ")}
  }
  
  // MARK: - On Ckick Action
  
  public func onClick(_ duration: CGFloat? = nil) {
    guard let state = state else { return }
    
    self.style = ButtonClick.Style.getClick(state: state)
    button?.onClick(views: getViews(), radius: cornerRadius, style: style, duration: duration)
  }
  
  // MARK: - Create Button
  
  
  public func createButton() {
    let btn = UIButton(type: .system)
    btn.frame = bounds
    btn.backgroundColor = .clear
    btn.setTitle(nil, for: .normal)
    btn.layer.cornerRadius = cornerRadius
    btn.clipsToBounds = true
    addSubview(btn)
    self.button = btn
  }
  
  // MARK: - Get Views
  
  func getViews(views: [UIView]? = nil) -> [UIView] {
    
    var nviews: [UIView] = []
    
    if let views = views {
      nviews = views
    } else {

//      if let addViews = addViews {
//        nviews = addViews
//      }
//      else {
        if allSubviews {
        
          if animType == ButtonClick._Style.color.rawValue ||
            animType == ButtonClick._Style.androidClickable.rawValue ||
            animType == ButtonClick._Style.androidClickableDark.rawValue {
          
          if let btn = button {
            
            if let addViews = addViews {
            if animType == ButtonClick._Style.androidClickable.rawValue ||
                animType == ButtonClick._Style.androidClickableDark.rawValue {
              
                if addViews.count == 1 {
                  let vi = addViews[0]
                  if let bb = button {
                    
                    bb.frame = vi.frame
                    //                vi.getButtonRadius(bb)
                    nviews.append(bb)
                  }
                }
              }
            } else {
              
              
              if !subviews.isEmpty, let vw = subviews.first {
                //              nviews.append(vw)
                
                let framee = vw.convert(vw.bounds, to: superview)
                btn.frame = framee
                //              vw.getButtonRadius(btn)
                nviews.append(btn)
                
              }
            }
            
          } else {
            if !subviews.isEmpty, let vw = subviews.first {
              nviews.append(vw)
            }
          }
          
          
        } else {
          
          nviews.append(self)
          subviews.forEach {
            nviews.append($0)
          }
        }
        
      }
        else {
          if animType == ButtonClick._Style.color.rawValue {
//
          if let addViews = addViews {

            if addViews.count == 1 {
              let vi = addViews[0]
              if let bb = button {
                
                bb.frame = vi.frame
//                vi.getButtonRadius(bb)
                nviews.append(bb)
              }
            } else {

              for vv in addViews {
                if let _ = vv as? UILabel {
                  nviews.append(vv)
                } else if let desFig = vv as? DesignableView, desFig.brWidth != 0, desFig.brColor != .clear {
                  nviews.append(vv)
                } else if vv.layer.borderWidth != 0, vv.layer.borderColor != UIColor.clear.cgColor {
                  nviews.append(vv)
                } else
                if let bb = button {
                  bb.frame = vv.frame
                  
//                  vv.getButtonRadius(bb)
                  nviews.append(bb)
                }
              }
            }
          } else {
            if let btn = button {
              
//              let sFrame = superview?.bounds ?? .zero
//              let cFrame = btn.bounds
//
//              if sFrame.width == cFrame.width, sFrame.height == cFrame.height {
//
//                subviews.forEach {
//                  let subFrame = $0.bounds
//
//                  var tempViews: [UIView] = []
//                  if sFrame.width == subFrame.width, sFrame.height == subFrame.height {
//
//                  } else {
//                    tempViews.append($0)
//                  }
//                  if !tempViews.isEmpty {
//                    let vi = tempViews[0]
//                    let frame = vi.convert(vi.bounds, to: superview)
//                    btn.frame = frame
////                    vi.getButtonRadius(btn)
//                    nviews.append(btn)
//                  }
//                }
//
//              } else {
                nviews.append(btn)
//              }
              
             
            }
          }
        }
        
          else if animType == ButtonClick._Style.androidClickable.rawValue ||
              animType == ButtonClick._Style.androidClickableDark.rawValue,
                let btn = button
        {
          
        
          if let addViews = addViews {
            btn.frame = addViews[0].frame
            let oneView = addViews[0]
            let frame = oneView.convert(oneView.bounds, to: superview)

            btn.frame = frame
//            oneView.getButtonRadius(btn)
          }
          if let addViews = addViews {
            nviews = addViews
          }
          nviews.append(btn)
        }
        else if subviews.count != 0 {
          
          if let addViews = addViews {
            nviews = addViews
          } else {
            let mainView = subviews[0]
            nviews.append(mainView)
          }
        }
      }
      
    }
    return nviews
  }
}

//MARK: - Colors random

extension UIColor {
  
  static func random() -> UIColor {
    func r() -> CGFloat { CGFloat(arc4random()) / CGFloat(UInt32.max) }
    return UIColor(red: r(), green: r(), blue: r(), alpha: 1.0)
  }
}

extension UIView {
  func getButtonRadius(_ btn: UIButton) {
    if btn.layer.cornerRadius == 0 {
      if let desFig = self as? DesignableView, desFig.cornerRadius != 0 {
        btn.layer.cornerRadius = desFig.cornerRadius
      } else if self.layer.cornerRadius != 0 {
        btn.layer.cornerRadius = self.layer.cornerRadius
      }
    }
  }
}
