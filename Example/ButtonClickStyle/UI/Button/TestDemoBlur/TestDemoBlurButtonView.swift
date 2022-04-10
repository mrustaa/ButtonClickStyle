import UIKit





class TestDemoBlurButtonView: BtnView {
  
  @IBOutlet var shadowwView: DesignableView!
  @IBOutlet var mainView: DesignableView!
  @IBOutlet var groupView: DesignableView!
  @IBOutlet var mainH: NSLayoutConstraint!
  @IBOutlet var mainW: NSLayoutConstraint!
  @IBOutlet var fillView: DesignableView!
  @IBOutlet private weak var titleLabel: UILabel?
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state
    
    if let type = state.animationType {
      
      var fr: CGRect = .init(x: 50, y: 29, width: 140, height:  51)
      var addViews: [UIView]? = [groupView]
      
      
      mainH.constant = fr.size.height
      mainW.constant = fr.size.width
      
      if (type == ButtonClick._Style.shadow.rawValue) ||
          (type == ButtonClick._Style.shadowColor.rawValue )
      {
        addViews = [mainView]
        mainView.fillColor = .clear
        let sizee: CGFloat = 30
        
//        fr = .init(x: 40, y: 19, width: 160, height: 91 )
        
        fr = .init(x: (fr.origin.x - sizee), y: (fr.origin.y - sizee), width: (fr.width + (sizee * 2)), height: (fr.height + (sizee * 2)))
        
        mainH.constant = fr.size.height
        mainW.constant = fr.size.width
        mainView.setNeedsLayout()
        
//        mainView.setNeedsLayout()
      } else if (type == ButtonClick._Style.colorFlat.rawValue) {
        
        addViews = [mainView]
      } else if type == ButtonClick._Style.androidClickable.rawValue ||
                  type == ButtonClick._Style.androidClickableDark.rawValue {
        addViews = nil
      }  else {
        mainView.fillColor = .clear
        mainView.setNeedsLayout()
      }
      
      
      
      let viewAn = ButtonClickStyleView(
        state: state,
        frame: fr,
        radius: 14,
        addViews: addViews
      )
      viewAn.insertSubview(mainView, at: 0)
      viewAn.updateSubviews()
      
      
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
