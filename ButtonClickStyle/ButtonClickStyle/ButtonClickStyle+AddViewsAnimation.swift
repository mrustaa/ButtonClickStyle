//
//  ViewAnimationSelect.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 22.06.2021.
//

import UIKit

extension UIButton {

  // MARK: Add View
  
  func addClickStyle(
    view: UIView?,
    style: ButtonClick.Style = .alpha(0.0),
    duration: CGFloat? = nil,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    guard let view = view else { return }
    addClickStyle(views: [view], style: style, callback: callback)
  }
  
  // MARK: Add Views
  
  func addClickStyle(
    views: [UIView],
    radius: CGFloat? = nil,
    style: ButtonClick.Style = .alpha(0.0),
    duration: CGFloat? = nil,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    
    switch style {
    case .androidClickable(let value, let dark): do {
      if views.count != 1 { return }
      guard let frontButton = views.last else { return }
      
      var tapAdded: Bool = false
      gestureRecognizers?.forEach {
        if $0 is UITapGestureRecognizer {
          tapAdded = true
        }
      }
      if !tapAdded {
        let tap = ButtonClick.Style.GestureRecognizer { [weak self] sender in
            guard let self = self else { return }
            
            let touchPoint = sender.location(in: frontButton)
            let dur = ButtonClick.Style.androidClickable(value, dark: dark).defaultDuration()
            self.androidPulseAnimation(radius: value, duration: dur, dark: dark, position: touchPoint)
            
          }
        frontButton.addGestureRecognizer(tap)
      }
    }
    default: break
    }
    
    
    click(for: .touchDown) { [weak self] in
      guard let self = self else { return }
      callback?(.touchDown)
//      Logs.add(".touchDown")
      
      self.addClickStyleAnimation(with: views, radius: radius, style: style, event: .touchDown, duration: duration)
    }
    
    click(for: .touchUpInside) { [weak self] in
      guard let self = self else { return }
      callback?(.touchUpInside)
//      Logs.add(".touchUpInside")
      self.addClickStyleAnimation(with: views, radius: radius, style: style, event: .touchUpInside, visible: true)
    }
    
    click(for: .touchUpOutside) { [weak self] in
      guard let self = self else { return }
      callback?(.touchUpOutside)
//      Logs.add(".touchUpOutside")
      self.addClickStyleAnimation(with: views, radius: radius, style: style, event: .touchUpOutside, visible: true)
    }
    
    click(for: .touchCancel) { [weak self] in
      guard let self = self else { return }
      callback?(.touchCancel)
//      Logs.add(".touchCancel")
      self.addClickStyleAnimation(with: views, radius: radius, style: style, event: .touchCancel, visible: true)
    }
  }
  
  // MARK: - onClick
  
  func onClick(
    views: [UIView],
    radius: CGFloat? = nil,
    style: ButtonClick.Style = .alpha(0.0),
    duration: CGFloat? = nil,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    
    if views.count == 0 {
      
    }
    print("onClick \(style.indx()) \(style.str())")
    
    switch style {
    case .androidClickable(let value, let dark):
      
      func randPointAndroidPulse() {
        let view = views[0]
        let position: CGPoint = .init(x: CGFloat.random(min: 0, max: view.width), y: CGFloat.random(min: 0, max: view.height))
        let dur = ButtonClick.Style.androidClickable(value, dark: dark).defaultDuration()
        androidPulseAnimation(radius: value, duration: dur, dark: dark, position: position)
      }
      main(delay: 0.1) {
        randPointAndroidPulse()
        main(delay: 0.15) {
          randPointAndroidPulse()
          main(delay: 0.22) {
            randPointAndroidPulse()
            main(delay: 0.1) {
              randPointAndroidPulse()
            }
          }
        }
      }
      
    default:
      main(delay: 0.1) { [weak self] in
        self?.addClickStyleAnimation(with: views, radius: radius, style: style, event: .touchDown, duration: duration)
        main(delay: 0.35) { [weak self] in
          self?.addClickStyleAnimation(with: views, radius: radius, style: style, event: .touchUpInside, duration: duration, visible: true)
        }
      }
    }
  }
  
  // MARK: - De-Select
  
  func deselected(_ views: [UIView]) {
    
    if (tag < 0) || (10 < tag) { return }
    
    addClickStyleAnimation(
      with: views,
      style: ButtonClick.Style.allCases[tag-1],
      visible: true
    )
  }
  
  
  // MARK: - Animation Filter
  
  func addClickStyleAnimation(
    with views: [UIView],
    radius: CGFloat? = nil,
    style: ButtonClick.Style,
    event: UIControl.Event = .touchUpInside,
    duration: CGFloat? = nil,
    visible: Bool = false
  ) {
    
    tag = style.indx()
    print(" duration \(duration ?? 0) 👌 \(style.str()) 👌 \(event.strName())")
    
    let dur: CGFloat = duration ?? style.defaultDuration()
    switch style {
    case .alpha(let value):
      
      updateChangeAlpha(with: views, visible: visible, value: 1.0 - value, duration: dur)
    case .shadow(let value, let color):
      if event == .touchDown {
        updateLayerGray(with: views, color: color, cornRadius: radius,  visible: false, value: value, duration: dur / 3)
      } else {
        updateLayerGray(with: views, color: color, cornRadius: radius, visible: true, value: value, duration: dur)
      }
    default: break
    }
    
    switch style {
    case .press(let power):
      
      if views.count > 0 {
        views[0].press(duration: dur, cornRadius: radius, value: power, shadow: false, visible: event != .touchDown)
      }
      if views.count > 1 {
//        views[1].press(duration: dur, cornRadius: radius, value: 0.5, shadow: true, visible: event != .touchDown)
      }
      
    default: break
    }
    
    
    views.forEach {
      switch style {
      case .flash(let value):
        $0.flash(value: value, duration: dur)
        
      case .color(let value, let color):
        
        if event == .touchDown {
          $0.animationColorTouchDown(cornRadius: radius, color: color, alpha: value)
        } else if event == .touchUpInside {
          $0.animationColor(duration: dur, cornRadius: radius, color: color, alpha: value)
        }
        
      case .colorFlat(let value, let color):
        if event == .touchDown {
          $0.animationColorFlat(duration: dur, cornRadius: radius, visible: false, value: value,  color: color)
        } else if event == .touchUpInside {
          $0.animationColorFlat(duration: dur, cornRadius: radius, visible: true, value: value,  color: color)
        }
        
      case .pulsate(let value, let new):
        if new {
          $0.pulsateNew(duration: dur, value: value, visible: visible)
        } else {
          if event == .touchDown {
            $0.pulsate(value: value, duration: dur)
          }
        }
        
//      case .press(let power):
//        $0.press(duration: dur, value: power, visible: event != .touchDown)
        
      case .shake(let value, let new):
        if new { $0.shake(value: value, duration: dur) }
        else { $0.shakeNew(value: value, duration: dur) }
      default: break
      }
    }
  }
  
}


// MARK: - Control.Event Names

extension UIControl.Event {
  
  func strName() -> String {
    return enevtName(self)
  }
  
  func enevtName(_ event: UIControl.Event) -> String {
    switch event {
    case .touchDown:      return "touch.Down"
    case .touchCancel:    return "touch.Cancel"
    case .touchUpOutside: return "touch.Up.Outside"
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
