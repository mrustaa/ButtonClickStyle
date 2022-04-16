import UIKit

class SubscribeButtonView: BtnView {
  
  @IBOutlet var mainView: UIView!
  @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var secondImageView: UIImageView?
  
  
  @IBOutlet var backColor: ButtonClickStyleDesignView!
  @IBOutlet var shadowVieww: ButtonClickStyleDesignView!
  @IBOutlet var cardView: UIView!
  @IBOutlet var fillView: ButtonClickStyleDesignView!
  
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
     
     
     let fr: CGRect = .init(x: 15 , y: 20.5, width: 172, height: 52)
     let viewAn = ButtonClickStyleView(
      state: state,
      frame: fr,
      radius: 26,
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
     
     self.btnClickStyleView?.removeFromSuperview()
     self.btnClickStyleView = viewAn
     var frr = mainView.frame;frr.origin = .zero;mainView.frame = frr
   }
     titleLabel?.text = state.titleText
       // secondImageView?.image = state.secondImage
        
  }
}
