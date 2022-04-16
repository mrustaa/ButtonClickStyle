import UIKit

// MARK: - State

extension ButtonListItem {
  struct State {
    var buttonState: ButtonClick.State?
    var clickAnimType: ButtonClick.Full?
    var buttonType: Int?
    var titleText: String?
    var subtitleText: String?
    var text2: String?
    var text3: String?
    var text4: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class ButtonListItem: TableAdapterItem {
  init(state: ButtonListItem.State) {
    let cellData =  ButtonListCellData(state: state)
    super.init(cellClass: ButtonListCell.self, cellData: cellData)
  }
}

// MARK: - Data

class ButtonListCellData: TableAdapterCellData {

  var state: ButtonListItem.State

  init(state: ButtonListItem.State) {
    self.state = state
    super.init()
    // self.cellClickCallback = state.handlers.onClickAt
  }
  
  override public func cellHeight() -> CGFloat {
    // let calcHeight = calculateLabel(
    //   text: state.titleText,
    //   padding: 16,
    //   titleFont: SFProText.regular.size(.headline)
    // )
    return Self.cHeight()
  }
  
  public static func cHeight() -> CGFloat  {
    return 93.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class ButtonListCell: TableAdapterCell {
  
  public var data: ButtonListCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  
  @IBOutlet var buttonClickView: JustPinkButtonView?
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  var buttonsAdded: [BtnView] = []
  var labelsAdded: [UILabel] = []
  
  override func awakeFromNib() {
    separator(hide: true)
//    button?.tapHideAnimation(
//      view: cardView,
//      type: .alpha(0.5),
//      callback: { [weak self] type in
//        if type == .touchUpInside {
//          self?.data?.state.handlers.onClickAt?()
//        }
//      }
//    )
  }
  
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? ButtonListCellData else { return }
    self.data = data
    guard let state = data.state.buttonState else { return }
    guard let clickAnimType = data.state.clickAnimType else { return }
    guard let buttonType = data.state.buttonType else { return }
     
    buttonClickView?.removeFromSuperview()
    
//    titleLabel?.text = data.state.titleText
//    subtitleLabel?.text = data.state.subtitleText
//    label2?.text = data.state.text2
//    label3?.text = data.state.text3
//    label4?.text = data.state.text4
    
    
    buttonsAdded.forEach { $0.removeFromSuperview() }
    buttonsAdded.removeAll()
    
    labelsAdded.forEach { $0.removeFromSuperview() }
    labelsAdded.removeAll()
    
    
    let child: BtnView? = ButtonClick.Buttons.newBtnView(buttonType)
    
    self.subtitleLabel?.text = ButtonClick.Buttons.allNameFull[buttonType] // .name
    self.titleLabel?.text = clickAnimType.base
    
    if let child = child {
      child.fill(state: state)
      child.frame = .init(
        x: 0,
        y: 0,
        width: 202,
        height: 93
      )
      self.addSubview(child)
      buttonsAdded.append(child)
    }
   
//    let state: ButtonClick.State = getState()
//    buttonClickView.fill(state: state)
  }
}
