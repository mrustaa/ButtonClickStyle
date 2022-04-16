import UIKit

class GoogleButtonView: BtnView {
  
  @IBOutlet var mainView: UIView!
  @IBOutlet var shadowVieww: ButtonClickStyleDesignView!
  @IBOutlet var cardView: UIView!
  @IBOutlet var fillView: ButtonClickStyleDesignView!
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var secondImageView: UIImageView?
    
  @IBOutlet var backColor: UIView!
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state

   
   if let type = state.animationType {
     
       var addViews: [UIView]? = []
     if type == ButtonClick._Style.press.rawValue {
       addViews = [cardView, shadowVieww]
     } else if type == ButtonClick._Style.androidClickable.rawValue ||
                type == ButtonClick._Style.androidClickableDark.rawValue {
       addViews = nil
     } else if type == ButtonClick._Style.color.rawValue {
       addViews = nil
       
     }  else {
       addViews = [mainView]
       }
     
     if !state.addBackgrondColor {
       backgroundColor = .clear
     }
     backColor.isHidden = !state.addBackgrondColor
     
     let fr: CGRect = .init(x: 35.5, y: 22.5, width: 131, height: 48)
     let radius: CGFloat = 24
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
//        secondImageView?.image = state.secondImage
        
  }
}
