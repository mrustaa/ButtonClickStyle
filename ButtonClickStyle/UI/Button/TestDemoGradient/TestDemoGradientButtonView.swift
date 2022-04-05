import UIKit





class TestDemoGradientButtonView: BtnView {
  
  @IBOutlet var shadowwView: DesignableView!
  @IBOutlet var fillView: DesignableView!
  @IBOutlet var mainView: UIView!
  @IBOutlet private weak var titleLabel: UILabel?
  
  @IBOutlet var backColor: DesignableView!
  override func fill(state: BtnCellState?) {
    guard let state = state else { return }
    self.state = state
    
    if let _ = state.animationType {
      let fr: CGRect = .init(x: 45, y: 20, width: 161, height: 58)
      let viewAn = ButtonClickStyleView(
        state: state,
        frame: fr,
        radius: 20
      )
      viewAn.insertSubview(mainView, at: 0)
      viewAn.updateSubviews()
      
      if !state.addBackgrondColor {
        backgroundColor = .clear
      }
      backColor.isHidden = !state.addBackgrondColor
      
      addSubview(viewAn)
      viewAn.translatesAutoresizingMaskIntoConstraints = false
      viewAn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      viewAn.topAnchor.constraint(equalTo: self.topAnchor, constant: fr.origin.y).isActive = true
      viewAn.widthAnchor.constraint(equalToConstant: fr.width).isActive = true
      viewAn.heightAnchor.constraint(equalToConstant: fr.height).isActive = true
      
      self.animation?.removeFromSuperview()
      self.animation = viewAn
      mainView.origin = .zero
    }
    
    titleLabel?.text = state.titleText
    
  }
}
