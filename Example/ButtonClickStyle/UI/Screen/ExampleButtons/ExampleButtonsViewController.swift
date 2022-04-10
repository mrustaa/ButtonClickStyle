import UIKit

//MARK: - ExampleAnimations Screen

class ExampleButtonsViewController: StoryboardController {
  
  var colorChanging: Bool = false
  @IBOutlet var colorDesignableView: DesignableView!
  var colorSelected: UIColor?
  let colorPicker = UIColorPickerViewController()
  
  @IBOutlet var allSubviewsSwitch: UISwitch!
  @IBOutlet var addBackgroundColorSwitch: UISwitch!
  @IBOutlet var createStartClick: UISwitch!
  @IBOutlet var debugButtonShow: UISwitch!
  
  @IBOutlet var testValueLabel: UILabel!
  @IBOutlet var testTypePicker: UIPickerView?
  @IBOutlet var testValueSlider: UISlider!
  var animationType: Int = 0
  var buttonType: Int = 1
  
  var buttonsAdded: [BtnView] = []
  var labelsAdded: [UILabel] = []
  var buttonTypes: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    colorPicker.delegate = self
    
//    title = "Click Style Animations"
    
    buttonTypes = ButtonClick.Buttons.shortCases.map { $0.rawValue }
    
    allSubviewsSwitch.addTarget(self, action: #selector(allSubviewsSwitchAction(swtch:event:)), for: .valueChanged)
    
    addBackgroundColorSwitch.addTarget(self, action: #selector(addBackgroundColorSwitchAction(swtch:event:)), for: .valueChanged)
    
    debugButtonShow.addTarget(self, action: #selector(adebugButtonShowSwitchAction(swtch:event:)), for: .valueChanged)
    
    testValueSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    
    
    createStartClick.addTarget(self, action: #selector(createStartClickSwitchAction(swtch:event:)), for: .valueChanged)
    
    update()
  }
  
  var aaa: CGFloat = 0
  var bbb: CGFloat = 0
  
  func update() {
    
    buttonsAdded.forEach { $0.removeFromSuperview() }
    buttonsAdded.removeAll()
    
    labelsAdded.forEach { $0.removeFromSuperview() }
    labelsAdded.removeAll()
    
    aaa = 0
    bbb = 0
    
    buttonTypes.enumerated().forEach {  (index, name) in
      self.buttonType = index
//      self.animationType = index
//      self.animationType =  Int(arc4random_uniform(13))
      self.updateButtons()
    }
    
    
    
  }
  
  
  var buttonTypesCopy: [Int] = []
  
  //MARK: - Get State
  
  func getValue() -> CGFloat {
    CGFloat(testValueSlider.value)
  }
  
  func getState() -> ButtonClick.State {
    return .init(
      titleText: buttonTypes[buttonType],
      allSubviews: animationType == ButtonClick._Style.color.rawValue ? false : allSubviewsSwitch.isOn,
      animationType: animationType,
      animationTypeValue: getValue(),
      new: buttonType == 1,
      color: colorSelected,
      startClick: createStartClick.isOn,
      debugButtonShow: debugButtonShow.isOn,
      addBackgrondColor: addBackgroundColorSwitch.isOn
    )
  }
  
  func getFrame() -> CGRect {
    let size: CGSize = .init(width: 240, height: 95)
    let padding: CGPoint = .init(x: 40, y: 40)
    let offs: CGPoint = .init(x: 0, y: 0)
    let framee: CGRect = .init(
      x: padding.x + ((aaa) * size.width + offs.x) ,
      y: padding.y + ((bbb) * size.height + offs.y) ,
      width: size.width,
      height: size.height
    )
    
//    aaa = aaa + 1
//    if aaa == 1 {
//      aaa = 0
//      bbb = bbb + 1
//    }
    
    print(" \(buttonType) 🐸🐸 \(aaa) 🐥 \(bbb) ")
    
    return framee
  }
  
  @IBAction func colorPickerAction(_ sender: Any) {
    resetAllColorChangeFlags()
    colorChanging = true
    present(colorPicker, animated: true, completion: nil)
  }
  
  @objc func allSubviewsSwitchAction(swtch: UISwitch, event: UIEvent) {
    update()
  }
  
  @objc func addBackgroundColorSwitchAction(swtch: UISwitch, event: UIEvent) {
    update()
  }
  
  @objc func adebugButtonShowSwitchAction(swtch: UISwitch, event: UIEvent) {
    update()
  }
  
  
  @objc func createStartClickSwitchAction(swtch: UISwitch, event: UIEvent) {
    update()
  }
  
  @IBAction func buttonReloadAction(_ sender: Any) {
    update()
  }
  
  @IBAction func buttonColorClear(_ sender: Any) {
    colorSelected = nil
    colorDesignableView.fillColor = .clear
    colorDesignableView.setNeedsLayout()
    update()
  }
  
  
  //MARK: - Slider Action
  
  @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
    if let touchEvent = event.allTouches?.first {
      switch touchEvent.phase {
      case .ended:
//        updateButtons()
        update()
      default:
        break
      }
    }
    
    let v = String(format: "%.2f",slider.value)
    
    testValueLabel.text = v
    
    testTypePicker?.reloadAllComponents()
  }
  
  //MARK: - Update Buttons View
  
  func updateButtons() {
    
    
    
    let state: ButtonClick.State = getState()
    
    
    var child: BtnView?
    
    switch buttonType { //
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
    case 13: child = BorderGreenDarkButtonView()
    case 14: child = TestDemoBlurButtonView()
    case 15: child = TestDemoSquaresButtonView()
    default:  break
    }
    
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 19)
    label.frame = getFrame()
    label.text =  buttonTypes[buttonType]
    label.xx = label.xx + 250
    label.yy = label.yy - 12
    label.wwidth = label.wwidth + 100
    self.view.addSubview(label)
    labelsAdded.append(label)
    
//    var xX: CGFloat = 440
//    let xP: CGFloat = 20
//    let xW: CGFloat = 40
//    let xA: CGFloat = 0.7
//    let xC: CGFloat = 0.025
//    let xF: CGFloat = 19
//
//    label = UILabel()
//    label.font = UIFont.boldSystemFont(ofSize: xF)
//    label.textAlignment = .center
//    label.frame = getFrame()
//    label.text = buttonTypes[animationType].base // //.isEmpty ? "" : "☑️"
//    label.xx = xX
//    label.wwidth = xW + 30
//    label.yy = label.yy - 12
//    label.alpha = 0.0
//    label.backgroundColor = .black.withAlphaComponent(xC)
//    self.view.addSubview(label)
//    labelsAdded.append(label)
//    xX = label.right + xP
//
//    let xD: CGFloat = 1.5
//    label = UILabel()
//    label.font = UIFont.boldSystemFont(ofSize: xF)
//    label.textAlignment = .center
//    label.frame = getFrame()
//    label.text = buttonTypes[animationType].emoji.color //.isEmpty ? "" : "☑️"
//    label.xx = xX
//    label.wwidth = xW
//    label.alpha = xA / xD
//    label.backgroundColor = .black.withAlphaComponent(xC * xD)
//    label.yy = label.yy - 12
//    self.view.addSubview(label)
//    labelsAdded.append(label)
//    xX = label.right + xP
//
//    label = UILabel()
//    label.font = UIFont.boldSystemFont(ofSize: xF)
//    label.textAlignment = .center
//    label.frame = getFrame()
//    label.text = buttonTypes[animationType].emoji.repeats.isEmpty ? "" : "☑️"
//    label.xx = xX
//    label.wwidth = xW
//    label.yy = label.yy - 12
//    label.alpha = xA
//    label.backgroundColor = .black.withAlphaComponent(xC)
//    self.view.addSubview(label)
//    labelsAdded.append(label)
//    xX = label.right + xP
//
//    label = UILabel()
//    label.font = UIFont.boldSystemFont(ofSize: xF)
//    label.textAlignment = .center
//    label.frame = getFrame()
//    label.text = buttonTypes[animationType].emoji.new //.isEmpty ? "" : "☑️"
//    label.xx = xX
//    label.wwidth = xW
//    label.yy = label.yy - 12
//    label.alpha = xA
//    label.backgroundColor = .black.withAlphaComponent(xC)
//    self.view.addSubview(label)
//    labelsAdded.append(label)
//    xX = label.right + xP
    
    if let child = child {
      child.fill(state: state)
      child.frame = getFrame()
      self.view.addSubview(child)
      buttonsAdded.append(child)
    }
    
    aaa = aaa + 1
    if aaa == 1 {
      aaa = 0
      bbb = bbb + 1
    }
  }
  
  
}

extension ExampleButtonsViewController: UIColorPickerViewControllerDelegate {
  
  func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    
    if colorChanging
    {
      colorSelected = viewController.selectedColor
    }
  }
  
  func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController)
  {
    update()
    colorDesignableView.fillColor = colorSelected
    colorDesignableView.setNeedsLayout()
    resetAllColorChangeFlags()
    
  } // ends colorPickerViewControllerDidFinish
  
  func resetAllColorChangeFlags()
  {
    colorChanging = false
    
  } // ends resetAllColorChangeFlags
}

//MARK: - PickerView DataSource

extension ExampleButtonsViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ButtonClick.Style.allNameFull.count
  }
}


//MARK: - PickerView Delegate

extension ExampleButtonsViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var pickerLabel: UILabel? = (view as? UILabel)
    if pickerLabel == nil {
      pickerLabel = UILabel()
      pickerLabel?.font = UIFont.systemFont(ofSize: 18)
      pickerLabel?.adjustsFontSizeToFitWidth = true
      pickerLabel?.minimumScaleFactor = 0.7
      pickerLabel?.textAlignment = .right
    }
    
    var text: String = ""
        text = ButtonClick.Style.allNameFull[row].name

    
    pickerLabel?.text = text
    pickerLabel?.textColor = UIColor.black
    
    return pickerLabel!
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

    return ButtonClick.Style.allNameFull[row].name
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    animationType = row
    update()
  }
}
