import UIKit


class DownloadButtonView: BtnView {
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet var mainView: DesignableView!
  @IBOutlet var shadowView: DesignableView!
  @IBOutlet var mainTitleLabel: UILabel!
  
  @IBOutlet var fillView: UIView!
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state
    
    
    
   if let type = state.animationType {
     var addViews: [UIView]? = []
     if type == ButtonClick.Style.press(0.5).indx() {
       addViews = [fillView, shadowView]
       mainView.fillColor = .clear
       mainView.setNeedsLayout()
     } else if type == ButtonClick._Style.androidClickable.rawValue ||
                type == ButtonClick._Style.androidClickableDark.rawValue {
       addViews = nil
     }  else {
       addViews = [mainView]
     }
     
     let fr: CGRect = .init(x: 14 , y: 19, width: 174, height: 57)
     let radius = 3.0
     fillView.layer.cornerRadius = radius
     fillView.clipsToBounds = true
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
     mainView.origin = .zero
   }
    mainTitleLabel?.text = state.titleText
       // secondImageView?.image = state.secondImage
        
  }
}
