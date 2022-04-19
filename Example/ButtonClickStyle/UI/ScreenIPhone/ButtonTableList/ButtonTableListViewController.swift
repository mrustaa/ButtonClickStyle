import UIKit

//MARK: - ButtonTableList ViewController

class ButtonTableListViewController: StoryboardController {
  
  @IBOutlet var tableView: TableAdapterView!
  var buttonTypes: [ButtonClick.Buttons] = []
  var buttonTypeSel: ButtonClick.Buttons = .JustPink
  var buttonType: Int = 0
  var clickAnimTypes: [ButtonClick.Full] = []
  var clickAnimType: Int = 0
  
  var buttonsAdded: [BtnView] = []
  var labelsAdded: [UILabel] = []
  
  
  
  
  var panelShow: Bool = false
  @IBOutlet var panelWidth: NSLayoutConstraint!
  @IBOutlet var tableTop: NSLayoutConstraint!
  
  @IBOutlet var animationTypePicker: UIPickerView!
  
  @IBOutlet var allSubviewsSwitch: UISwitch!
  @IBOutlet var addBackgroundColorSwitch: UISwitch!
  @IBOutlet var createStartClick: UISwitch!
  @IBOutlet var debugButtonShow: UISwitch!
  
  @IBOutlet var animationValueLabel: UILabel!
  @IBOutlet var animationValueSlider: UISlider!
  
  @IBOutlet var animationDurationLabel: UILabel!
  @IBOutlet var animationDurationSlider: UISlider!
  
  @IBOutlet var colorClearButton: UIButton!
  @IBOutlet var colorSelectButton: UIButton!
  var colorChanging: Bool = false
  @IBOutlet var colorButtonClickStyleDesignView: ButtonClickStyleDesignView!
  var colorSelected: UIColor?
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
      self.tableView.scrollToBottom()
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
        self.tableView.scrollToTop()
      }
      
    }
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.8) {
      self.animationTypePicker.selectRow(ButtonClick._Style.allCases.count - 1, inComponent: 0, animated: true)
      
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
        self.animationTypePicker.selectRow(0, inComponent: 0, animated: true)
      }
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    navigationItem.title = "Table Buttons Customizable"
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "",
      style: .plain,
      target: nil,
      action: nil
    )
    
    let barButtonReload = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(navBarButtonReloadAction(_:)) )
    
    
    let barButtonShowHidePanel = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(navBarShowHidePanel))
    
    navigationItem.rightBarButtonItems = [barButtonShowHidePanel, barButtonReload]
    
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
    buttonTypes = ButtonClick.Buttons.allCases
    
    
    buttonColorClearAction()
    updateButtons()
    navBarShowHidePanel()
    
  }
  
  
  //MARK: - Update Buttons View
  
  func updateButtons() {
    
    
    
    var items: [TableAdapterItem] = []
    
  
    
    buttonTypes.forEach {
      
      buttonTypeSel = $0
      buttonType = $0.index()
        
        items.append(
          ButtonListItem(
            state: .init(
              buttonState: getState(type: $0),
              clickAnimType: clickAnimTypes[clickAnimType],
              buttonType: $0.index()
            )
          )
        )
      
    }
    tableView.set(items: items)
  }

  func getValue() -> CGFloat {
    CGFloat(animationValueSlider.value)
  }
  
  func getState(type: ButtonClick.Buttons) -> ButtonClick.State {
    
    let dur: CGFloat? = animationDurationSlider.value != 0.0 ? CGFloat(animationDurationSlider.value) : nil
    
    return .init(
      titleText: type.name(),
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
    if #available(iOS 14.0, *) {
      let colorPicker = UIColorPickerViewController()
      colorPicker.delegate = self
      present(colorPicker, animated: true, completion: nil)
    } else {
      colorNotPicker()
    }
  }
  
  func colorNotPicker() {
    colorSelected = UIColor.random()
    colorSelectButton.setTitle("", for: .normal)
    colorClearButton.setTitle("Color Clear", for: .normal)
    let indigo = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
    colorClearButton.setTitleColor(indigo, for: .normal)
    colorClearButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 12)
    
    updateButtons()
    colorButtonClickStyleDesignView.fillColor = colorSelected
    colorButtonClickStyleDesignView.setNeedsLayout()
    resetAllColorChangeFlags()
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
  
  
  @objc func navBarShowHidePanel() {
    panelShow = !panelShow
    
    self.panelWidth.constant = self.panelShow ? 194 : 0
    self.tableTop.constant = self.panelShow ? 194 : 0
    UIView.animate(withDuration: 0.5, animations: {
      self.view.layoutIfNeeded()
    })
    
  }
  
  @objc func navBarButtonReloadAction(_ sender: Any) {
    updateButtons()
  }
  
  @IBAction func buttonReloadAction(_ sender: Any) {
    updateButtons()
  }
  
  @IBAction func buttonColorClearAction() {
    colorSelected = nil
    colorSelectButton.setTitle("👇", for: .normal)
    colorClearButton.setTitle("Color Select", for: .normal)
    colorClearButton.setTitleColor(.black, for: .normal)
    colorClearButton.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
    colorButtonClickStyleDesignView.fillColor = .clear
    colorButtonClickStyleDesignView.setNeedsLayout()
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
    let val = slider.value
    let v = (val == 0.0) ? "default" : String(format: "%.2f",val)
    animationDurationLabel.text = v
  }
  
}

extension ButtonTableListViewController: UIColorPickerViewControllerDelegate {
  
  @available(iOS 14.0, *)
  func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    
    
    if colorChanging {
      colorSelected = viewController.selectedColor
      colorSelectButton.setTitle("", for: .normal)
      colorClearButton.setTitle("Color Clear", for: .normal)
      colorClearButton.setTitleColor(.systemIndigo, for: .normal)
      colorClearButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 12)
    }
  }
  
  @available(iOS 14.0, *)
  func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController)
  {
    updateButtons()
    colorButtonClickStyleDesignView.fillColor = colorSelected
    colorButtonClickStyleDesignView.setNeedsLayout()
    resetAllColorChangeFlags()
    
  }
  
  func resetAllColorChangeFlags() {
    colorChanging = false
  }
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
    pickerLabel?.textColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
    
    return pickerLabel!
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    return ButtonClick.Style.allNameFull[row].name
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    clickAnimType = row
    
    if row == ButtonClick._Style.colorFlat.rawValue ||
        row == ButtonClick._Style.color.rawValue {
//      allSubviewsSwitch.setOn(false, animated: true)
      allSubviewsSwitch.alpha = 0.5
      allSubviewsSwitch.isUserInteractionEnabled = false
    } else {
      
      allSubviewsSwitch.alpha = 1
      allSubviewsSwitch.isUserInteractionEnabled = true
    }
    
    updateButtons()
  }
}
