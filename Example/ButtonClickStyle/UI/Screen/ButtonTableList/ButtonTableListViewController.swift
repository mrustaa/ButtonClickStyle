import UIKit

//MARK: - ButtonTableList ViewController

class ButtonTableListViewController: StoryboardController {
  
  @IBOutlet var tableView: TableAdapterView!
  var buttonTypes: [String] = []
  var buttonType: Int = 0
  var clickAnimTypes: [ButtonClick.Full] = []
  var clickAnimType: Int = 0
  
  var buttonsAdded: [BtnView] = []
  var labelsAdded: [UILabel] = []
  
  
  
  
  
  @IBOutlet var animationTypePicker: UIPickerView!
  
  @IBOutlet var allSubviewsSwitch: UISwitch!
  @IBOutlet var addBackgroundColorSwitch: UISwitch!
  @IBOutlet var createStartClick: UISwitch!
  @IBOutlet var debugButtonShow: UISwitch!
  
  
  @IBOutlet var animationValueLabel: UILabel!
  @IBOutlet var animationValueSlider: UISlider!
//  var animationTypeLast: Int = 0w
  
  @IBOutlet var animationDurationLabel: UILabel!
  @IBOutlet var animationDurationSlider: UISlider!
  
  @IBOutlet var colorClearButton: UIButton!
  var colorChanging: Bool = false
  @IBOutlet var colorDesignableView: DesignableView!
  var colorSelected: UIColor?
  let colorPicker = UIColorPickerViewController()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    colorPicker.delegate = self
    
    
    allSubviewsSwitch.addTarget(self, action: #selector(allSubviewsSwitchAction(swtch:event:)), for: .valueChanged)
    addBackgroundColorSwitch.addTarget(self, action: #selector(addBackgroundColorSwitchAction(swtch:event:)), for: .valueChanged)
    debugButtonShow.addTarget(self, action: #selector(adebugButtonShowSwitchAction(swtch:event:)), for: .valueChanged)
    createStartClick.addTarget(self, action: #selector(createStartClickSwitchAction(swtch:event:)), for: .valueChanged)
    
    
    animationValueSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    
    animationDurationSlider.addTarget(self, action: #selector(onSliderDurationChanged(slider:event:)), for: .valueChanged)
    
    
    animationTypePicker.delegate = self
    animationTypePicker.dataSource = self
    animationTypePicker.tag = 1
    
    clickAnimTypes = ButtonClick.Style.allNameFull
    buttonTypes = ButtonClick.Buttons.shortNames
    
    updateButtons()
    // Do any additional setup after loading the view.
  }
  
  
  //MARK: - Update Buttons View
  
  func updateButtons() {
    
    
    
    var items: [TableAdapterItem] = []
    
    buttonTypes.enumerated().forEach { indx, tpe in
      
      if clickAnimTypes.count > indx {
        
        buttonType = indx
//        clickAnimType = indx
        //      buttonTypes[animationType]
        items.append(
          ButtonListItem(
            state: .init(
              buttonState: getState(),
              clickAnimType: clickAnimTypes[indx],
              buttonType: indx)
          )
        )
      }
    }
    tableView.set(items: items)
  }

  func getValue() -> CGFloat {
    CGFloat(animationValueSlider.value)
  }
  
  func getState() -> ButtonClick.State {
    
    let dur: CGFloat? = animationDurationSlider.value != 0.0 ? CGFloat(animationDurationSlider.value) : nil
    
    return .init(
      titleText: buttonTypes[buttonType],
      allSubviews: allSubviewsSwitch.isOn,
      animationType: clickAnimType,
      animationTypeValue: getValue(),
      animationDuration: dur,
      new: buttonType == 1,
      color: colorSelected,
      startClick: createStartClick.isOn,
      debugButtonShow: debugButtonShow.isOn,
      addBackgrondColor: addBackgroundColorSwitch.isOn
    )
  }
  
  @IBAction func colorPickerAction(_ sender: Any) {
    resetAllColorChangeFlags()
    colorChanging = true
    present(colorPicker, animated: true, completion: nil)
  }
  
  @objc func allSubviewsSwitchAction(swtch: UISwitch, event: UIEvent) {
    updateButtons()
  }
  
  @objc func addBackgroundColorSwitchAction(swtch: UISwitch, event: UIEvent) {
    updateButtons()
  }
  
  @objc func createStartClickSwitchAction(swtch: UISwitch, event: UIEvent) {
    updateButtons()
  }
  
  
  @objc func adebugButtonShowSwitchAction(swtch: UISwitch, event: UIEvent) {
    updateButtons()
  }
  
  
  @IBAction func buttonReloadAction(_ sender: Any) {
    updateButtons()
  }
  
  @IBAction func buttonColorClear(_ sender: Any) {
    colorSelected = nil
    colorDesignableView.fillColor = .clear
    colorDesignableView.setNeedsLayout()
    updateButtons()
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
    
    animationValueLabel.text = v
    
    animationTypePicker.reloadAllComponents()
  }
  
  
  @objc func onSliderDurationChanged(slider: UISlider, event: UIEvent) {
    if let touchEvent = event.allTouches?.first {
      switch touchEvent.phase {
      case .ended:
        updateButtons()
      default:
        break
      }
    }
    let v = String(format: "%.2f",slider.value)
    animationDurationLabel.text = v
  }
  
}

extension ButtonTableListViewController: UIColorPickerViewControllerDelegate {
  
  func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    
    if colorChanging
    {
      colorSelected = viewController.selectedColor
    }
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

//MARK: - PickerView DataSource

extension ButtonTableListViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ButtonClick.Style.allNameFull.count
  }
}


//MARK: - PickerView Delegate

extension ButtonTableListViewController: UIPickerViewDelegate {
  
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
    clickAnimType = row
    updateButtons()
  }
}
