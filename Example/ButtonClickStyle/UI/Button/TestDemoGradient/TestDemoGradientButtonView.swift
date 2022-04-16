import UIKit





class TestDemoGradientButtonView: BtnView {
  
  @IBOutlet var shadowwView: ButtonClickStyleDesignView!
  @IBOutlet var fillView: ButtonClickStyleDesignView!
  @IBOutlet var mainView: UIView!
  @IBOutlet private weak var titleLabel: UILabel?
  
  @IBOutlet var backColor: ButtonClickStyleDesignView!
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state
    
    if let type = state.animationType {
      
      
      var addViews: [UIView]? = nil
      if type == ButtonClick._Style.androidClickable.rawValue ||
          type == ButtonClick._Style.androidClickableDark.rawValue {
        addViews = [fillView]
      } else if (type == ButtonClick._Style.color.rawValue) {
        addViews = [fillView]
      }
      
      
      let fr: CGRect = .init(x: 45, y: 20, width: 161, height: 58)
      let viewAn = ButtonClickStyleView(
        state: state,
        frame: fr,
        radius: 20,
        addViews: addViews
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
      
      self.btnClickStyleView?.removeFromSuperview()
      self.btnClickStyleView = viewAn
      
      var frr = mainView.frame
      frr.origin = .zero
      mainView.frame = frr
    }
    
    titleLabel?.text = state.titleText
    
  }
}
