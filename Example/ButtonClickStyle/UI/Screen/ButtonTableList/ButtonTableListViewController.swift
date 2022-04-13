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
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    clickAnimTypes = ButtonClick.Style.allNameFull
    buttonTypes = ButtonClick.Buttons.shortNames
    
    var items: [TableAdapterItem] = []
    
    buttonTypes.enumerated().forEach { indx, tpe in
      
      if clickAnimTypes.count > indx {
        
        buttonType = indx
        clickAnimType = indx
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
    // Do any additional setup after loading the view.
  }
  
  
  func getState() -> ButtonClick.State {
    return .init(
      titleText: buttonTypes[buttonType],
      allSubviews: true,
      animationType: clickAnimType,
      //      animationTypeValue: getValue(),
      //      new: buttonTypeLast == 1,
      //      color: colorSelected,
      startClick: true,
      addBackgrondColor: true
    )
  }
  
}
