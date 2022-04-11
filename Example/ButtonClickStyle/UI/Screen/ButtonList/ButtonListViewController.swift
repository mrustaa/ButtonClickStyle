import UIKit

//MARK: - ButtonList ViewController


private let buttonLayerExamplTag = 77

class ButtonListViewController: StoryboardController {
  
  @IBOutlet var buttonPresentView: DesignableView!
  
  @IBOutlet var buttonLayerExampleView: ButtonLayerExampleView?
  @IBOutlet var buttonTypePicker: UIPickerView!
  @IBOutlet var animationTypePicker: UIPickerView!
  
  @IBOutlet var animationValueLabel: UILabel!
  @IBOutlet var animationValueSlider: UISlider!
  var animationTypeLast: Int = 0
  var buttonTypeLast: Int = 0
  
  
  
  @IBOutlet var colorClearButton: UIButton!
  var colorChanging: Bool = false
  @IBOutlet var colorDesignableView: DesignableView!
  var colorSelected: UIColor?
  let colorPicker = UIColorPickerViewController()
  
  
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
    "Neomorphism",
    
    "Test Button",
    "Test Random",
    "Test 3 Squares",
    "Green"
  ]
  
  
  @IBAction func colorPickerAction(_ sender: Any) {
    resetAllColorChangeFlags()
    colorChanging = true
    present(colorPicker, animated: true, completion: nil)
  }
  
  @IBAction func buttonColorClear(_ sender: Any) {
    colorSelected = nil
    colorClearButton.isHidden = true
    colorDesignableView.fillColor = .clear
    colorDesignableView.setNeedsLayout()
    updateButtons()
  }
  
  
  @IBAction func buttonReloadAction(_ sender: Any) {
    updateButtons()
  }
  
  //MARK: - viewDidAppear
  
  @IBAction func exampleButtonsScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(ExampleButtonsViewController.instantiate(), animated: true)
  }
  
  
  @IBAction func exampleAnimationsScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(ExampleAnimationsViewController.instantiate(), animated: true)
  }
  
  @IBAction func buttonListScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(ButtonListViewController.instantiate(), animated: true)
  }
  
  @IBAction func testScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(TestViewController.instantiate(), animated: true)
  }
  
  @IBAction func testDemoScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(TestDemoViewController.instantiate(), animated: true)
  }
  
  
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
    
    colorPicker.delegate = self
    
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
  
  //MARK: - Create ButtonLayerExample
  
  func createButtonLayerExampleView(enable: Bool = true) {

    if !enable {
      self.removeButtonLayerExampleView()
      ButtonLayerExampleView.exmpStart = enable
    }
    
    
    var next: Int?
    var type: Int = 0
    if let v = self.buttonLayerExampleView?.animationType {
      let t = ButtonClick.Style.allCases[v]
      print(" 💙 ButtonLayerExampleView Old \(t.full())")
      
      var _next = (v + 1)
      
      if  _next == ButtonClick.Style.color(0.5, color: .red).indx() ||
            _next == ButtonClick.Style.colorFlat(0.5, color: .red).indx() {
        _next = ButtonClick.Style.allCases[5].indx()
      } else if _next == ButtonClick.Style.androidClickable(0.5, color: nil).indx() {
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
    
    self.removeButtonLayerExampleView()
    
//    main(delay: 1) { [weak self] in
//      guard let self = self else { return }
      
      let exampleView = ButtonLayerExampleView()
      exampleView.tag = buttonLayerExamplTag
      exampleView.animationDuration = 0.3 // 0.45 //  //
    exampleView.animationDelay = 0.0 // 0.6 // 1.0 // //
      exampleView.animationType = type
      exampleView.update()
      exampleView.frame = .init(x: 0, y: 60, width:  UIScreen.main.bounds.size.width, height: 223)
      
      exampleView.endAnimationCallback = { [weak self] in
        
//        main(delay: 1) { [weak self] in
//          guard let self = self else { return }
          
//          let t = ButtonClick.Style.allCases[mSelf.buttonLayerExampleView.animationType ?? 0]
//          print(" ‼️ endAnimationCallback \(t.full()) ‼️ ‼️")
          self?.createButtonLayerExampleView()
//        }
      }
//      exampleView.start()
      exampleView.buttonStartStopAction()
      self.buttonLayerExampleView = exampleView
      self.view.addSubview(exampleView)
//    }
    
  }
  
  func removeButtonLayerExampleView() {
    
    if let find = self.view.viewWithTag(buttonLayerExamplTag) {
      find.subviews.forEach { v1 in
        v1.removeFromSuperview()
      }
      find.removeFromSuperview()
    }
    self.view.subviews.forEach { v in
      if v.tag == buttonLayerExamplTag {
        v.removeFromSuperview()
      }
    }
    self.buttonLayerExampleView?.removeFromSuperview()
    self.buttonLayerExampleView = nil
  }

  //MARK: - Get State
  
  func getValue() -> CGFloat {
    CGFloat(animationValueSlider.value)
  }
  
  func getState() -> ButtonClick.State {
    return .init(
      titleText: buttonTypes[buttonTypeLast],
      allSubviews: true, // animationType == ButtonClick._Style.color.rawValue ? false : allSubviewsSwitch.isOn,
      animationType: animationTypeLast,
      animationTypeValue: getValue(),
      new: buttonTypeLast == 1,
      color: colorSelected,
      startClick: true,// createStartClick.isOn,
      addBackgrondColor: true// addBackgroundColorSwitch.isOn
    )
  }
//
//  func getState() -> ButtonClick.State {
//    let type = animationTypeLast
//    let name = buttonTypes[buttonTypeLast]
//    let state: ButtonClick.State = .init(titleText: name, animationType: type, animationTypeValue: getValue(), new: buttonTypeLast == 1)
//    return state
//  }
  
  //MARK: - Update Buttons View
  
  func updateButtons() {
    
    
    let state: ButtonClick.State = getState()
    
    
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
    case 12: child = TestDemoGradientButtonView()
    case 13: child = TestDemoBlurButtonView()
    case 14: child = TestDemoSquaresButtonView()
    case 15: child = BorderGreenDarkButtonView()
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


extension ButtonListViewController: UIColorPickerViewControllerDelegate {
  
  func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    
    if colorChanging
    {
      colorSelected = viewController.selectedColor
    }
    colorClearButton.isHidden = (colorSelected == nil) || (colorSelected == .clear)
  }
  
  func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController)
  {
    updateButtons()
    colorDesignableView.fillColor = colorSelected
    colorDesignableView.setNeedsLayout()
    resetAllColorChangeFlags()
    
  } // ends colorPickerViewControllerDidFinish
  
  func resetAllColorChangeFlags()
  {
    colorChanging = false
    
  } // ends resetAllColorChangeFlags
}
