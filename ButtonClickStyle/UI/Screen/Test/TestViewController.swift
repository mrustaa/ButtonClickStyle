import UIKit

//MARK: - Test ViewController

class TestViewController: StoryboardController {
  
  @IBOutlet var allSubviewsSwitch: UISwitch!
  @IBOutlet var counterTypeStepper: UIStepper!
  
  @IBOutlet var buttonAnim1View: ButtonClickStyleView?
  @IBOutlet var buttonAnim2View: ButtonClickStyleView?
  @IBOutlet var buttonAnim3View: ButtonClickStyleView?
  
  @IBOutlet var typeLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "",
      style: .plain,
      target: nil,
      action: nil
    )
    
    title = "Test"
    
    update()
  }
  
  @IBAction func allSubviewsSwitchAction(_ sender: UISwitch) {
    update()
  }
  
  @IBAction func counterAction(_ sender: UIStepper) {
    update()
  }
  
  func update() {
    let type: Int = Int(counterTypeStepper.value)
    let allSubv: Bool = allSubviewsSwitch.isOn
    
    typeLabel.text = "\(ButtonClick.Style.allCases[type].str())"
    
    buttonAnim1View?.update(animationType: type, allSubviews: allSubv)
    buttonAnim2View?.update(animationType: type, allSubviews: allSubv)
    buttonAnim3View?.update(animationType: type, allSubviews: allSubv)
  }
}
