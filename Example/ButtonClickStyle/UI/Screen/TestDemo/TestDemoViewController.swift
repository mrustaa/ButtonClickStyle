import UIKit

//MARK: - Test ViewController

class TestDemoViewController: StoryboardController {
  
  var colorChanging: Bool = false
  @IBOutlet var colorDesignableView: DesignableView!
  var colorSelected: UIColor?
  let colorPicker = UIColorPickerViewController()
  
  @IBOutlet var allSubviewsSwitch: UISwitch!
  @IBOutlet var addBackgroundColorSwitch: UISwitch!
  @IBOutlet var createStartClick: UISwitch!
  
  @IBOutlet var testValueLabel: UILabel!
  @IBOutlet var testTypePicker: UIPickerView!
  @IBOutlet var testValueSlider: UISlider!
  var testTypeLast: Int = 0
  var buttonTypeLast: Int = 0
  
  var buttonsAdded: [BtnView] = []
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    colorPicker.delegate = self
    
    title = "Test Demo"
    
    createStartClick.addTarget(self, action: #selector(createStartClickSwitchAction(swtch:event:)), for: .valueChanged)
    
    allSubviewsSwitch.addTarget(self, action: #selector(allSubviewsSwitchAction(swtch:event:)), for: .valueChanged)
    
    addBackgroundColorSwitch.addTarget(self, action: #selector(addBackgroundColorSwitchAction(swtch:event:)), for: .valueChanged)
    
    testValueSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    
    update()
  }
  
  var aaa: CGFloat = 0
  var bbb: CGFloat = 0
  
  func update() {
    
    buttonsAdded.forEach {
      $0.removeFromSuperview()
    }
    buttonsAdded.removeAll()
    
    aaa = 0
    bbb = 0
    
    buttonTypes.enumerated().forEach {  (index, name) in
      self.buttonTypeLast = index
//      self.testTypeLast =  Int(arc4random_uniform(13))
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
      titleText: buttonTypes[buttonTypeLast],
      allSubviews: allSubviewsSwitch.isOn,
      animationType: testTypeLast,
      animationTypeValue: getValue(),
      new: buttonTypeLast == 1,
      color: colorSelected,
      startClick: createStartClick.isOn,
      addBackgrondColor: addBackgroundColorSwitch.isOn
    )
  }
  
  func getFrame() -> CGRect {
    let size: CGSize = .init(width: 240, height: 98)
    let padding: CGPoint = .init(x: 80, y: 80)
    let offs: CGPoint = .init(x: 10, y: 10)
    let framee: CGRect = .init(
      x: padding.x + ((aaa) * size.width + offs.x) ,
      y: padding.y + ((bbb) * size.height + offs.y) ,
      width: size.width,
      height: size.height
    )
    
    aaa = aaa + 1
    if aaa == 3 {
      aaa = 0
      bbb = bbb + 1
    }
    
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
  
  @objc func createStartClickSwitchAction(swtch: UISwitch, event: UIEvent) {
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
    
    testTypePicker.reloadAllComponents()
  }
  
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
    
    if let child = child {
      child.fill(state: state)
      child.frame = getFrame()
      self.view.addSubview(child)
      buttonsAdded.append(child)
    }
  }
  
  
}

extension TestDemoViewController: UIColorPickerViewControllerDelegate {
  
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

extension TestDemoViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ButtonClick.Style.allName.count
  }
}


//MARK: - PickerView Delegate

extension TestDemoViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var pickerLabel: UILabel? = (view as? UILabel)
    if pickerLabel == nil {
      pickerLabel = UILabel()
      pickerLabel?.font = UIFont.systemFont(ofSize: 18)
      pickerLabel?.adjustsFontSizeToFitWidth = true
      pickerLabel?.minimumScaleFactor = 0.7
      pickerLabel?.textAlignment = .left
    }
    
    var text: String = ""
      text = ButtonClick.Style.allName[row]

    
    pickerLabel?.text = text
    pickerLabel?.textColor = UIColor.black
    
    return pickerLabel!
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

      return ButtonClick.Style.allName[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    testTypeLast = row
    update()
  }
}
