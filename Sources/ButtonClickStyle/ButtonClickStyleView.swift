//
//  ButtonClickStyleView.swift
//  ButtonLayersButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 09.03.2022.
//

import UIKit

// MARK: - ButtonClickStyleView

@IBDesignable
open class ButtonClickStyleView: UIView {
  
  @IBInspectable public var animType: Int = 0
  @IBInspectable public var animValue: CGFloat = 0.0
  @IBInspectable public var animColor: UIColor = .clear
  @IBInspectable public var animDuration: CGFloat = 0.0
  @IBInspectable public var cornerRadius: CGFloat = 0.0
  @IBInspectable public var allSubviews: Bool = true
  @IBInspectable public var startClick: Bool = false
  @IBInspectable public var debugButtonShow: Bool = false
  
  public var click: ButtonClick.ClosureEvent? {
    didSet {
      button?.click = click
    }
  }
  
  public var addViews: [UIView]?
  var state: ButtonClick.State?
  
  private var style: ButtonClick.Style = .alpha(0.5)
  private var setupDone = false
  private var button: ButtonClickStyleButton?
  
  // MARK: - Initialize
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    updateSubviews()
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  public init(
    state: ButtonClick.State,
    frame: CGRect,
    radius: CGFloat = 0.0,
    addViews: [UIView]? = nil,
    click: ButtonClick.ClosureEvent? = nil
  ) {
    
    super.init(frame: frame)
    
    var type: Int = state.animationType ?? self.animType
    if let style = state.animationStyle {
      type = style.rawValue
    }
    
    var state = state
    if type == ButtonClick._Style.colorFlat.rawValue ||
        type == ButtonClick._Style.color.rawValue {
      state.allSubviews = false
    }
    
    self.click = click
    
    self.state = state
    self.cornerRadius = radius
    self.layer.cornerRadius = radius
    self.allSubviews = state.allSubviews
    self.animType = type
    self.addViews = addViews
    self.debugButtonShow = state.debugButtonShow
    
  }
  
  public func createState() {
    
    if self.state == nil {
      var allSubviews = self.allSubviews
      if animType == ButtonClick._Style.colorFlat.rawValue {
        allSubviews = false
      }
      
      let animVal: CGFloat? =  animValue    != 0.0    ? animValue    : nil
      let animDur: CGFloat? =  animDuration != 0.0    ? animDuration : nil
      let animClr: UIColor? =  animColor    != .clear ? animColor    : nil
      
      self.state = .init(
        allSubviews: allSubviews,
        animationType: animType,
        animationTypeValue: animVal,
        animationDuration: animDur,
        color: animClr,
        startClick: startClick,
        debugButtonShow: debugButtonShow
      )
    }
  }
  
  // MARK: - Layout subViews Update
  
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    createState()
    updateSubviews()
  }
  
  // MARK: - Update Subviews
  
  public func updateSubviews() {
    
    if setupDone { return }
    guard let state = state else { return }
    
    self.style = ButtonClick.Style.getClick(state: state)
    
    var onlyButtonReturn = true
    switch style.typeEasy() {
    case .color, .androidClickable, .androidClickableDark: onlyButtonReturn = false
    default: break
    }
    
    if button == nil {
      let button = createButton()
      self.button = button
    }
    
    if onlyButtonReturn {
      let nviews = getViews()
      if nviews.count == 1 {
        if nviews[0] is ButtonClickStyleButton {
          return
        }
      }
    }
    
    setAnimation(style: style)
      
    updateStartClick()
    
    setupDone = true
  }
  
  public func updateStartClick() {
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
    updateSubviews()
    if let btn = button {
      btn.isUserInteractionEnabled = true
    }
  }
  
  
  // MARK: - Set Animation Style
  
  public func setAnimation(style: ButtonClick.Style, views: [UIView]? = nil) {
    layer.cornerRadius = cornerRadius
    
    let nviews = getViews(views: views)
    
    button?.addClickStyle(views: nviews, radius: cornerRadius, style: style, callback: { event in
      
    })
  }
  
  // MARK: - On Ckick Action
  
  public func onClick(_ duration: CGFloat? = nil) {
    guard let state = state else { return }
    
    self.style = ButtonClick.Style.getClick(state: state)
    button?.onClick(views: getViews(), radius: cornerRadius, style: style, duration: duration)
  }
  
  // MARK: - Create Button
  
  
  public func createButton() -> ButtonClickStyleButton {
    let btn = ButtonClickStyleButton(frame: bounds, click: self.click) //UIButton(type: .system)
    btn.frame = bounds
    btn.backgroundColor = debugButtonShow ? .systemRed.withAlphaComponent(0.45) : .clear
    btn.setTitle(nil, for: .normal)
    btn.layer.cornerRadius = cornerRadius
    btn.clipsToBounds = true
    btn.isUserInteractionEnabled = true
    addSubview(btn)
    return btn
  }
  
  // MARK: - Get Views
  
  public func getViews(views: [UIView]? = nil) -> [UIView] {
    
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
            }
            else {
              
//              if !subviews.isEmpty {
//                subviews.enumerated().forEach { indx, v1 in
//
//                  var findMain = false
//                    let sBounds = self.bounds
//                    if (sBounds.size.width == v1.bounds.size.width) &&
//                        (sBounds.size.height == v1.bounds.size.height) {
//                      findMain = true
//                    }
//
//
//                  if !findMain {
//
//                    let button = createButton()
//                    if let desFig = v1 as? ButtonClickStyleDesignView, desFig.cornerRadius != 0 {
//                      button.layer.cornerRadius = desFig.cornerRadius
//                    }
//                    button.frame = v1.frame
//                    self.buttons.append(button)
//
//                    nviews.append(button)
//                  }
//                }
//              }
              
              
              if !subviews.isEmpty, let vw = subviews.first {
                //              nviews.append(vw)
                
                if let desFig = vw as? ButtonClickStyleDesignView, desFig.cornerRadius != 0 {
                  btn.layer.cornerRadius = desFig.cornerRadius
                }
//                btn.frame  = vw.convert(vw.bounds, to: superview)
                
//                btn.frame  = vw.convert(vw.bounds, to: self)

                btn.frame = vw.frame
                
                
                let sBounds = self.bounds
                if (sBounds.size.width == btn.bounds.size.width) &&
                    (sBounds.size.height == btn.bounds.size.height) {
                  
                  var btnFr = btn.frame
                  btnFr.origin = .zero
                  btn.frame = btnFr
                }
                
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
                } else if let desFig = vv as? ButtonClickStyleDesignView, desFig.brWidth != 0, desFig.brColor != .clear {
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
            nviews = addViews
          }
            
              let sBounds = self.bounds
              if (sBounds.size.width == btn.bounds.size.width) &&
                  (sBounds.size.height == btn.bounds.size.height) {


                if !subviews.isEmpty, let vw = subviews.first {

                  if let desFig = vw as? ButtonClickStyleDesignView, desFig.cornerRadius != 0 {
                    btn.layer.cornerRadius = desFig.cornerRadius
                  }
                  btn.frame  = vw.convert(vw.bounds, to: superview)

                }
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
  public func getButtonRadius(_ btn: ButtonClickStyleButton) {
    if btn.layer.cornerRadius == 0 {
      if let desFig = self as? ButtonClickStyleDesignView, desFig.cornerRadius != 0 {
        btn.layer.cornerRadius = desFig.cornerRadius
      } else if self.layer.cornerRadius != 0 {
        btn.layer.cornerRadius = self.layer.cornerRadius
      }
    }
  }
}
