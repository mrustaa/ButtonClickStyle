import UIKit

class FirefoxButtonView: BtnView {
  @IBOutlet var mainView: UIView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var backColor: ButtonClickStyleDesignView!
  @IBOutlet var gradientView: ButtonClickStyleDesignView!
  @IBOutlet var gradientBackView: ButtonClickStyleDesignView!
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state

   mainView.layer.cornerRadius = 24
   mainView.clipsToBounds = true

   if let type = state.animationType {
     
     var addViews: [UIView]? = []
     if type == ButtonClick.Style.colorFlat(0.5, color: .red).indx() {
       addViews = [gradientView]
     } else if type == ButtonClick._Style.androidClickable.rawValue ||
                type == ButtonClick._Style.androidClickableDark.rawValue {
       addViews = [gradientView]
     } else if type == ButtonClick._Style.color.rawValue {
       addViews = nil
       
     }  else {
       addViews = [mainView]
     }
     
     backColor.isHidden = !state.addBackgrondColor 
     
     let fr: CGRect = .init(x: 28, y: 22, width: 146, height: 49)
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
     
     self.btnClickStyleView?.removeFromSuperview()
     self.btnClickStyleView = viewAn
     var frr = mainView.frame;frr.origin = .zero;mainView.frame = frr
   }
     titleLabel?.text = state.titleText
        
  }
}
