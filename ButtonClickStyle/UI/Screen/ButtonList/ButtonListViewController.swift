import UIKit

//MARK: - ButtonList ViewController

class ButtonListViewController: StoryboardController {
  
  @IBOutlet var buttonPresentView: DesignableView!
  
  @IBOutlet var buttonLayerExampleView: ButtonLayerExampleView!
  @IBOutlet var buttonTypePicker: UIPickerView!
  @IBOutlet var animationTypePicker: UIPickerView!
  
  @IBOutlet var animationValueLabel: UILabel!
  @IBOutlet var animationValueSlider: UISlider!
  var animationTypeLast: Int = 0
  var buttonTypeLast: Int = 0
  
  let buttonTypes = [
    "JustPink",
    "No shadow",
    "Blue",
    "BuyNow",
    "Download",
    "Delete",
    "Search",
    "Subscribe",
    "Firefox",
    "Google",
    "Gr Button",
    "Neomorphism"
  ]
  
  
  //MARK: - viewDidAppear
  
  lazy var doSomethingOnce: () -> Void = {
    testDemoScreenButtonAction(.init())
    return {}
  }()
  
  override func viewDidAppear(_ animated: Bool) {
//    _ = doSomethingOnce
    
    main(delay: 0.35) {
      self.updateButtons()
//      self.pickerView(self.buttonTypePicker, didSelectRow: 0, inComponent: 0)
    }
  }
  
  //MARK: - viewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    animationValueSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    
    buttonTypePicker.delegate = self
    buttonTypePicker.dataSource = self
    buttonTypePicker.tag = 0
    
    
    animationTypePicker.delegate = self
    animationTypePicker.dataSource = self
    animationTypePicker.tag = 1
    
//    title = "ButtonList"
        
    createButtonLayerExampleView(enable: false)
  }
  
  
  @IBAction func testScreenPushButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(TestViewController.instantiate(), animated: true)
  }
  
  @IBAction func testDemoScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(TestDemoViewController.instantiate(), animated: true)
  }
  
  //MARK: - Create ButtonLayerExample
  
  func createButtonLayerExampleView(enable: Bool = true) {

    if !enable {
      buttonLayerExampleView.removeFromSuperview()
      ButtonLayerExampleView.exmpStart = enable
    }
    
    
    var next: Int?
    var type: Int = 0
    if let v = self.buttonLayerExampleView.animationType {
      let t = ButtonClick.Style.allCases[v]
      print(" 💙 ButtonLayerExampleView Old \(t.full())")
      
      var _next = (v + 1)
      
      if  _next == ButtonClick.Style.color(0.5, color: .red).indx() ||
            _next == ButtonClick.Style.colorFlat(0.5, color: .red).indx() {
        _next = ButtonClick.Style.allCases[5].indx()
      } else if _next == ButtonClick.Style.androidClickable(0.5, dark: false).indx() {
        _next = ButtonClick.Style.allCases[0].indx()
      }
      
      //        if n == ButtonClick.Style.allCases[ButtonClick.Style.allCases.count-3].indx() { //   ButtonClick.Style.shake(0.5, new: true).indx()
      //          n = ButtonClick.Style.allCases[0].indx()
      //        }
      next = _next
      
      let tt = ButtonClick.Style.allCases[_next]
      print(" 💜 ButtonLayerExampleView New \(tt.full())")
    }
    if next == nil {
      let t = ButtonClick.Style.alpha(0.5)
      print(" ❤️‍🔥🧡 ButtonLayerExampleView Start Default  \(t.full())")
    }
    type = next ?? ButtonClick.Style.alpha(0.5).indx()
    
    
    self.buttonLayerExampleView.removeFromSuperview()
    self.buttonLayerExampleView = nil
    
    main(delay: 1) { [weak self] in
      guard let self = self else { return }
      
      let exampleView = ButtonLayerExampleView()
      exampleView.animationDuration = 0.45 // 0.3 //
      exampleView.animationDelay = 1.0 // 0.6 //
      exampleView.animationType = type
      exampleView.update()
      exampleView.frame = .init(x: 0, y: 60, width:  UIScreen.main.bounds.size.width, height: 223)
      
      exampleView.endAnimationCallback = { [weak self] in
        
//        main { [weak self] in
          guard let mSelf = self else { return }
          
//          let t = ButtonClick.Style.allCases[mSelf.buttonLayerExampleView.animationType ?? 0]
//          print(" ‼️ endAnimationCallback \(t.full()) ‼️ ‼️")
//          mSelf.createButtonLayerExampleView()
//        }
      }
      exampleView.start()
      exampleView.buttonStartStopAction()
      self.buttonLayerExampleView = exampleView
      self.view.addSubview(exampleView)
    }
    
  }

  //MARK: - Get State
  
  func getValue() -> CGFloat {
    CGFloat(animationValueSlider.value)
  }
  
  func getState() -> BtnCellState {
    let type = animationTypeLast
    let name = buttonTypes[buttonTypeLast]
    let state: BtnCellState = .init(titleText: name, animationType: type, animationTypeValue: getValue(), new: buttonTypeLast == 1)
    return state
  }
  
  //MARK: - Update Buttons View
  
  func updateButtons() {
    
    
    let state: BtnCellState = getState()
    
    
    var child: BtnView?
    
    switch buttonTypeLast { //
    case  0: child = JustPinkButtonView()
    case  1: child = JustPinkButtonView()
    case  2: child = BlueButtonView()
    case  3: child = BuyNowButtonView()
    case  4: child = DownloadButtonView()
    case  5: child = DeleteButtonView()
    case  6: child = SearchButtonView()
    case  7: child = SubscribeButtonView()
    case  8: child = FirefoxButtonView()
    case  9: child = GoogleButtonView()
    case 10: child = GradientBlueBasicButtonView()
    case 11: child = NeomorphismButtonView()
    default:  break
    }
    
    buttonPresentView.fillColor = .clear
    buttonPresentView.subviews.forEach {
      $0.removeFromSuperview()
    }
    if let child = child {
      child.fill(state: state)
      buttonPresentView.addSubview(child)
      child.translatesAutoresizingMaskIntoConstraints = false
      child.topAnchor.constraint(equalTo: buttonPresentView.topAnchor, constant: 0).isActive = true
      child.bottomAnchor.constraint(equalTo: buttonPresentView.bottomAnchor, constant: 0).isActive = true
      child.leadingAnchor.constraint(equalTo: buttonPresentView.leadingAnchor, constant: 0).isActive = true
      child.trailingAnchor.constraint(equalTo: buttonPresentView.trailingAnchor, constant: 0).isActive = true
    }
  }
  
  //MARK: - Slider Action
  
  @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
    if let touchEvent = event.allTouches?.first {
      switch touchEvent.phase {
      case .ended:
        updateButtons()
      default:
        break
      }
    }
    
    let v = String(format: "%.2f",slider.value)
    
//    animationTypes = [
//      ".hide(alpha \(v))",
//      ".shadow(alpha \(v))", // ".layerGray(0.28)",
//      ".pulsate(force \(v))",
//      ".pulsate(force \(v), new)",
//      ".shake(force \(v))",
//      ".shake(force \(v), new)",
//      ".flash(alpha: \(v))",
//      ".color(alpha: \(v))",
//      ".androidClickable(ligth)",
//      ".androidClickable(dark)",
//    ]
    
    animationValueLabel.text = v
    
    animationTypePicker.reloadAllComponents()
  }
  
}

//MARK: - PickerView DataSource

extension ButtonListViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView.tag == 1 {
      return ButtonClick.Style.allName.count 
    } else {
      return buttonTypes.count
    }
  }
}

//MARK: - PickerView Delegate

extension ButtonListViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var pickerLabel: UILabel? = (view as? UILabel)
    if pickerLabel == nil {
      pickerLabel = UILabel()
      pickerLabel?.font = UIFont.systemFont(ofSize: 18)
      pickerLabel?.adjustsFontSizeToFitWidth = true
      pickerLabel?.minimumScaleFactor = 0.7
      pickerLabel?.textAlignment = pickerView.tag == 1 ? .left : .right
    }
    
    var text: String = ""
    if pickerView.tag == 1 {
      text = ButtonClick.Style.allName[row]
    } else {
      text = buttonTypes[row]
    }
    
    pickerLabel?.text = text
    pickerLabel?.textColor = UIColor.black
    
    return pickerLabel!
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView.tag == 1 {
      return ButtonClick.Style.allName[row]
    } else {
      return buttonTypes[row]
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView.tag == 1 {
      animationTypeLast = row
    } else {
      buttonTypeLast = row
    }
    
    updateButtons()
  }
}
