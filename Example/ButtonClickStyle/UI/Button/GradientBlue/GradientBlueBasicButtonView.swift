import UIKit

class GradientBlueBasicButtonView: BtnView {
  
  @IBOutlet var mainView: ButtonClickStyleDesignView!
  @IBOutlet var mainH: NSLayoutConstraint!
  @IBOutlet var mainW: NSLayoutConstraint!
  @IBOutlet var fillView: ButtonClickStyleDesignView!
  @IBOutlet var groupView: ButtonClickStyleDesignView!
  @IBOutlet private weak var titleLabel: UILabel?
    
  @IBOutlet var backColor: UIView!
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state

    if let type = state.animationType {
     
      var origin: CGPoint = .init(x: 22, y: 16.5)
     var addViews: [UIView]? = [groupView]
//     if type == 2 {
//       addViews = [fillView]
//     }
      
      mainH.constant = 60
      mainW.constant = 158
      
      if (type == ButtonClick._Style.shadow.rawValue) ||
          (type == ButtonClick._Style.shadowColor.rawValue )
     {
       addViews = [mainView]
        mainView.fillColor = .clear
        origin = .init(x: 12, y: 6.5)
        mainH.constant = 80
        mainW.constant = 178
        mainView.setNeedsLayout()
      } else if (type == ButtonClick._Style.colorFlat.rawValue) {
        addViews = [mainView]
      } else if type == ButtonClick._Style.androidClickable.rawValue ||
                  type == ButtonClick._Style.androidClickableDark.rawValue {
        addViews = nil
      }  else {
        mainView.fillColor = .clear
        mainView.setNeedsLayout()
      }
        
      
      if !state.addBackgrondColor {
        backgroundColor = .clear
      }
      backColor.isHidden = !state.addBackgrondColor 
      
     
      let fr: CGRect = .init(x: origin.x, y: origin.y, width: mainW.constant, height: mainH.constant)
     let radius: CGFloat = 30
     let viewAn = ButtonClickStyleView(
      state: state,
      frame: fr,
      radius: radius,
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
     var frr = mainView.frame;frr.origin = .zero;mainView.frame = frr
   }
   
     titleLabel?.text = state.titleText
        
  }
}
