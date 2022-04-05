import UIKit

// typealias ButtonLayerExampleButtonActionCallback = () -> Void

class ButtonLayerExampleView: XibView {
    
var endAnimationCallback: (() -> ())?
  
    // MARK: - IBOutlets
  @IBOutlet var fillView: UIView!
  
  
  @IBOutlet var startStopButton: UIButton!
  
  @IBOutlet var presentView: UIView!
  @IBOutlet var shadowView: DesignableView!
  @IBOutlet var elipseView: DesignableView!
  @IBOutlet var mainView: DesignableView!
  @IBOutlet var titleLabel: DesignableLabel!
  @IBOutlet var iconView: DesignableView!
  
  @IBOutlet var _groupView: UIView!
  @IBOutlet var _shadowView: DesignableView!
  @IBOutlet var _mainView: UIView!
  @IBOutlet var _elipseView: DesignableView!
  @IBOutlet var _titleLabel: DesignableLabel!
  @IBOutlet var _iconView: DesignableView!
  
  @IBOutlet var textTitleLabel: UILabel!
  @IBOutlet var typeLabel: UILabel!
  @IBOutlet var buttonAnimView: ButtonClickStyleView!
    
  static var exmpStart: Bool = true
  var animationDuration = 0.45
  var animationClickDuration: CGFloat?
  var animationType: Int?
  var animationDelay: CGFloat = 0.0
  var animationOptions: UIView.AnimationOptions = .curveEaseInOut
  
  var fr1: CGRect = .zero
  var fr2: CGRect = .zero
  var fr3: CGRect = .zero
  var fr4: CGRect = .zero
  var fr5: CGRect = .zero
  
  func animation(
    spring: Bool = true,
    back: Bool = false,
    duration: CGFloat? = nil, // 0.45
    animations: @escaping () -> Void,
    completion: ((Bool) -> Void)? = nil
  ) {
    var d: CGFloat = self.animationDuration
    if let duration = duration {
      d = duration
    }
    if back {
//      d = 0.05
    }
    
    if spring {
      UIView.animate(
        withDuration: TimeInterval(self.animationDuration),
        delay: 0,
        usingSpringWithDamping: 0.8,
        initialSpringVelocity: 6.0,
        options: [.allowUserInteraction],
        animations: animations,
        completion: completion
      )
    } else {
      UIView.animate(
        withDuration: TimeInterval(d),
        delay: 0,
        options: self.animationOptions,
        animations: animations,
        completion: completion
      )
    }
  }
  
  func update() {

    guard let type = animationType else { return }
    
    buttonAnimView.animationType = type
//    buttonAnimView.allSubviews
//    if type == ButtonClick.Style.color(0.5, color: .red).indx() {
//      buttonAnimView.addViews = [_mainView]
//      buttonAnimView.cornerRadius = 8
//      buttonAnimView.allSubviews = false
//    } else {
//      buttonAnimView.addViews = nil
//      buttonAnimView.allSubviews = true
//    }
    buttonAnimView.state?.animationDuration = animationClickDuration
    typeLabel.text = "\(ButtonClick.Style.allCases[type].str())"
    buttonAnimView.updateSubviews()
  }
  
  public func buttonStartStopAction() {
  
      self.startStopButton.setTitle(" \(ButtonLayerExampleView.exmpStart ? "🛑 Stop Hide" : "▶ Show Animated Demo")", for: .normal)
      
    let hideLevel = 0.25
    
      if !ButtonLayerExampleView.exmpStart {
        self.layer.removeAllAnimations()
        self.textTitleLabel.alpha = hideLevel / 2
        self.typeLabel.alpha = hideLevel / 2
        self.fillView.alpha = hideLevel
        self._groupView.alpha = hideLevel / 1.4
        self.presentView.alpha = hideLevel
      } else {
        self.textTitleLabel.alpha = 1
        self.typeLabel.alpha = 1
        self.fillView.alpha = 1
        self._groupView.alpha = 1
        self.presentView.alpha = 1
        self.start()
      }
    
  }
  
    override func setup() {
      
      startStopButton.click { [weak self] in
        ButtonLayerExampleView.exmpStart = !ButtonLayerExampleView.exmpStart
        
        guard let self = self else { return }
        main {
          self.buttonStartStopAction()
        }
      }
      
      backgroundColor = .clear
      
      iconView.alpha = 0
      titleLabel.alpha = 0
      mainView.alpha = 0
      elipseView.alpha = 0
      shadowView.alpha = 0
      
      _iconView.alpha = 1
      _titleLabel.alpha = 1
      _mainView.alpha = 1
      _elipseView.alpha = 1
      _shadowView.alpha = 1
      
      fr1 = _shadowView.frame
      fr2 = _mainView.frame
      fr3 = _elipseView.frame
      fr4 = _titleLabel.frame
      fr5 = _iconView.frame
    }
  
  func start() {
    step1()
  }
  
  func onClick() {
    self.buttonAnimView.onClick(animationClickDuration)
  }
  
  //MARK: - step 1) Animate Shadow
  
  func step1(_ back: Bool = false, duration: CGFloat? = nil) {
    if !ButtonLayerExampleView.exmpStart { return }
    
    if back {
      fillView.addSubview(presentView)
      fillView.addSubview(_groupView)
    } else {
      fillView.addSubview(_groupView)
      fillView.addSubview(presentView)
    }
    
    main(delay: animationDelay) { [weak self] in
      guard let self = self else { return }
      
      if back {
        self._shadowView.alpha = 1
        self.shadowView.alpha = 0
      }
      self.animation(spring: true, back: back, duration: duration, animations: {
        if back {
          self._shadowView.frame = self.fr1
        } else {
          self._shadowView.set(y: 112)
          self._shadowView.set(x: 189)
        }
      }, completion: { f in
        if !back {
          self._shadowView.alpha = 0
          self.shadowView.alpha = 1
        } else {
          self.shadowView.alpha = 0
          self.shadowView.isHidden = true
        }
        
        if !back {
          self.onClick()
        }
//        if back {
//          self.step3(back)
//        } else {
//          self.step2(back)
//        }
        
        
        if !back {
          self.step2(back)
        }
        
      })
    }
  }
  
  //MARK: - step 2) Animate Main
  
  func step2(_ back: Bool = false, duration: CGFloat? = nil) {
    if !ButtonLayerExampleView.exmpStart { return }
    
    if !back {
      fillView.addSubview(presentView)
      fillView.addSubview(_groupView)
    }
    
    main(delay: animationDelay) { [weak self] in
      guard let self = self else { return }
      if back {
        self._mainView.alpha = 1
        self.mainView.alpha = 0
      }
      self.animation(spring: true, back: back, duration: duration, animations: {
        
        if back {
          self._mainView.frame = self.fr2
        } else {
          self._mainView.set(y: 86)
          self._mainView.set(x: 172)
        }
      }, completion: { f in
        if !back {
          self._mainView.alpha = 0
          self.mainView.alpha = 1
        }
        
//        if !back {
          self.onClick()
//        }
        
        if back {
          self.endAnimationCallback?()
        }
        
        if !back {
          self.step3(back)
        }
      })
    }
  }
  
  //MARK: - step 3) Animate Elipse
  
  func step3(_ back: Bool = false, duration: CGFloat? = nil) {
    if !ButtonLayerExampleView.exmpStart { return }
    
    if !back {
      fillView.addSubview(_groupView)
      fillView.addSubview(presentView)
    }
    
    main(delay: animationDelay) { [weak self] in
      
      guard let self = self else { return }
      if back {
        self._elipseView.alpha = 1
        self.elipseView.alpha = 0
      } else {
        self._shadowView.alpha = 1
        self.shadowView.alpha = 0
      }
      self.animation(spring: true, back: back, duration: duration, animations: {
        
        
        if back {
          self._elipseView.frame = self.fr3
        } else {
          self._elipseView.set(y: 106)
          self._elipseView.set(x: 172)
        }
        
      }, completion: { f in
        if !back {
          self._elipseView.alpha = 0
          self.elipseView.alpha = 1
          
          self._shadowView.alpha = 0
          self.shadowView.alpha = 1
        }
        
        if !back {
          self.onClick()
        }
//        self.step4(back)
        
        if !back {
          self.step4(back)
        }
      })
    }
  }
  
  //MARK: - step 4) Animate Title
  
  func step4(_ back: Bool = false, duration: CGFloat? = nil) {
    if !ButtonLayerExampleView.exmpStart { return }
    
    if back {
      fillView.addSubview(presentView)
      fillView.addSubview(_groupView)
    } else {
      fillView.addSubview(presentView)
      fillView.addSubview(_groupView)
    }
    main(delay: animationDelay) { [weak self] in
      
      guard let self = self else { return }
      if back {
        self._titleLabel.alpha = 1
        self.titleLabel.alpha = 0
      }
      self.animation(spring: true, back: back, duration: duration, animations: {
        
        
        if back {
          self._titleLabel.frame = self.fr4
        } else {
          self._titleLabel.set(y: 100)
          self._titleLabel.set(x: 187)
        }
        
      }, completion: { f in
        if !back {
          self._titleLabel.alpha = 0
          self.titleLabel.alpha = 1
        }
        
        
        if !back {
          self.onClick()
        }
//        self.step5(back)
        
        if !back {
          self.step5(back)
        }
      })
    }
  }
  
  //MARK: - step 5) Animate Icon
  
  func step5(_ back: Bool = false, duration: CGFloat? = nil) {
    if !ButtonLayerExampleView.exmpStart { return }
    
    main(delay: animationDelay) { [weak self] in
      
      guard let self = self else { return }
      if back {
        self._iconView.alpha = 1
        self.iconView.alpha = 0
      }
      self.animation(spring: true, back: back, duration: duration, animations: {
        
        
        if back {
          self._iconView.frame = self.fr5
        } else {
          self._iconView.set(y: 98)
          self._iconView.set(x: 274)
        }
        
      }, completion: { f in
        if !back {
          self._iconView.alpha = 0
          self.iconView.alpha = 1
        }
        if !back {
          self.onClick()
        }
        
        if back {
//          self.step2(back)
        } else {
//          self.step1(!back)
          
          
          self.step1(true, duration: 0.27)//0.15)
          main(delay: 0.4) {
            self.step3(true, duration: 0.25)//0.18)
            main(delay: 0.3) {
              self.step4(true, duration: 0.22)
              main(delay: 0.2) {
                self.step5(true, duration: 0.18)//0.25)
                main(delay: 0.1) {
                  self.step2(true, duration: 0.15)//0.27)
                }
              }
            }
          }
          
        }
      })
    }
  }
}

extension UIView {
  
  func alphaAnim(_ value: CGFloat, delay: CGFloat = 0.0, duration: CGFloat = 1.0) {
    UIView.animate(withDuration: duration, delay: delay) {
      self.alpha = value
    }
  }
}
