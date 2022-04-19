//
//  ViewAnimationSelect.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 22.06.2021.
//

import UIKit

private let btnTapGesture = 49

extension ButtonClickStyleButton {

  // MARK: Add View
  
  public func addClickStyle(
    view: UIView?,
    style: ButtonClick.Style = .alpha(0.0),
    duration: CGFloat? = nil,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    guard let view = view else { return }
    addClickStyle(views: [view], style: style, callback: callback)
  }
  
  // MARK: Add Views
  
  public func addClickStyle(
    views: [UIView],
    radius: CGFloat? = nil,
    style: ButtonClick.Style = .alpha(0.0),
    duration: CGFloat? = nil,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    
    switch style {
    case .androidClickable(let value, let color): do {
      if views.count != 1 { return }
      guard let frontButton = views.last else { return }
      
      
      let tagAdded: Bool = frontButton.tag == btnTapGesture
      
      var tapAdded: Bool = false
      gestureRecognizers?.forEach {
        if $0 is UITapGestureRecognizer {
          tapAdded = true
        }
      }
      if !(tapAdded && tagAdded) {
        frontButton.tag = btnTapGesture
        let tap = ButtonClick.Style.GestureRecognizer { [weak self] sender in
          
            guard let self = self else { return }
            
            let touchPoint = sender.location(in: frontButton)
            let dur = ButtonClick.Style.androidClickable(value, color: color).defaultDuration()
            self.buttonClickStyleAndroidPulse(radius: value, duration: dur, color: color, position: touchPoint)
            
          }
        frontButton.addGestureRecognizer(tap)
      }
    }
    default: break
    }
    
    
    click(for: .touchDown) { [weak self] in
      guard let self = self else { return }
      callback?(.touchDown)
      self.addClickStyleAnimation(views: views, radius: radius, style: style, event: .touchDown, duration: duration)
    }
    
    click(for: .touchUpInside) { [weak self] in
      guard let self = self else { return }
      callback?(.touchUpInside)
      self.addClickStyleAnimation(views: views, radius: radius, style: style, event: .touchUpInside, visible: true)
    }
  }
  
  // MARK: - onClick
  
  public func onClick(
    views: [UIView],
    radius: CGFloat? = nil,
    style: ButtonClick.Style = .alpha(0.0),
    duration: CGFloat? = nil,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    
    self.click?(.allEvents)
//    print("onClick \(style.indx()) \(style.str())")
    
    switch style {
    case .androidClickable(let value, let color):
      
      func randPointAndroidPulse() {
        let view = views[0]
        
        let position: CGPoint = .init(x: CGFloat.random(min: 0, max: view.frame.size.width), y: CGFloat.random(min: 0, max: view.frame.size.height))
        let dur = ButtonClick.Style.androidClickable(value, color: color).defaultDuration()
        buttonClickStyleAndroidPulse(radius: value, duration: dur, color: color, position: position)
      }
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
        randPointAndroidPulse()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15) {
          randPointAndroidPulse()
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.22) {
            randPointAndroidPulse()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
              randPointAndroidPulse()
            }
          }
        }
      }
      
    default:
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak self] in
        self?.addClickStyleAnimation(views: views, radius: radius, style: style, event: .touchDown, duration: duration)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) { [weak self] in
          self?.addClickStyleAnimation(views: views, radius: radius, style: style, event: .touchUpInside, duration: duration, visible: true)
        }
      }
    }
  }
  
  // MARK: - De-Select
  
  public func deselected(_ views: [UIView]) {
    
    if (tag < 0) || (10 < tag) { return }
    
    addClickStyleAnimation(
      views: views,
      style: ButtonClick.Style.allCases[tag-1],
      visible: true
    )
  }
  
  
  // MARK: - Animation Filter
  
  public func addClickStyleAnimation(
    views: [UIView],
    radius: CGFloat? = nil,
    style: ButtonClick.Style,
    event: UIControl.Event = .touchUpInside,
    duration: CGFloat? = nil,
    visible: Bool = false
  ) {
    
    self.click?(event)
    
    tag = style.indx()
//    print(" duration \(duration ?? 0) 👌 \(style.str()) 👌 \(event.strName())")
    
    let dur: CGFloat = duration ?? style.defaultDuration()
    switch style {
    case .alpha(let value):
      
       buttonClickStyleAlpha(with: views, visible: visible, value: 1.0 - value, duration: dur)
    case .shadow(let value, let color):
      if event == .touchDown {
        buttonClickStyleShadow(with: views, color: color, cornRadius: radius,  visible: false, value: value, duration: dur / 3)
      } else {
        buttonClickStyleShadow(with: views, color: color, cornRadius: radius, visible: true, value: value, duration: dur)
      }
    default: break
    }
    
    switch style {
    case .fave(let power, let color):
      if event == .touchDown {
        if views.count > 1 {
          self.buttonClickStyleFave(mainView: views[1], secondView: views[0], color: color, value: power, duration: dur)
        }
      }
      
    case .press(let power):
      
      if views.count > 0 {
        views[0].buttonClickStylePress(duration: dur, cornRadius: radius, value: power, shadow: false, visible: event != .touchDown)
      }
      
    default: break
    }
    
    
    views.forEach {
      switch style {
        
      case .glare(let alpha, let color):
        if event == .touchDown {
          
          let v1 = $0
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            v1.buttonClickStyleGlareStop()
          }
          
          v1.buttonClickStyleGlareStop()
          $0.buttonClickStyleGlare(alpha: alpha, color: color, duration: dur)
        }
        
      case .flash(let value):
        $0.buttonClickStyleFlash(value: value, duration: dur)
        
      case .color(let value, let color):
        
        if event == .touchDown {
          $0.buttonClickStyleColorTouchDown(cornRadius: radius, color: color, alpha: value)
        } else if event == .touchUpInside {
          $0.buttonClickStyleColor(duration: dur, cornRadius: radius, color: color, alpha: value)
        }
        
      case .colorFlat(let value, let color):
        if event == .touchDown {
          $0.buttonClickStyleColorFlat(duration: dur, cornRadius: radius, visible: false, value: value,  color: color)
        } else if event == .touchUpInside {
          $0.buttonClickStyleColorFlat(duration: dur, cornRadius: radius, visible: true, value: value,  color: color)
        }
        
      case .pulsate(let value, let new):
        if new {
          $0.buttonClickStylePulsateNew(duration: dur, value: value, visible: visible)
        } else {
          if event == .touchDown {
            $0.buttonClickStylePulsate(value: value, duration: dur)
          }
        }
      case .shake(let value, let new):
        if new {
          $0.buttonClickStyleShake(value: value, duration: dur)
          
        }  else {
          $0.buttonClickStyleShakeNew(value: value, duration: dur)
        }
      default: break
      }
    }
  }
  
}


// MARK: - Control.Event Names

extension UIControl.Event {
  
  public func strName() -> String {
    return enevtName(self)
  }
  
  public func enevtName(_ event: UIControl.Event) -> String {
    switch event {
    case .touchDown:      return "touch.Down"
    case .touchUpInside:  return "touch.Up.Inside"
    default: return ""
    }
  }
}

// MARK: - Float Random

private extension Float {
  
  static var random: Float {
    return Float(arc4random()) / Float(0xFFFFFFFF)
  }
  static func random(min: Float, max: Float) -> Float {
    return Float.random * (max - min) + min
  }
}

private extension CGFloat {
  static var randomSign: CGFloat {
    return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
  }
  static var random: CGFloat {
    return CGFloat(Float.random)
  }
  static func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat.random * (max - min) + min
  }
}
