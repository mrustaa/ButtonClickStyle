import UIKit

class SubscribeButtonView: BtnView {
  
  @IBOutlet var mainView: UIView!
  @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var secondImageView: UIImageView?
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state
    
   if let _ = state.animationType {
     let fr: CGRect = .init(x: 15 , y: 20.5, width: 172, height: 52)
     let viewAn = ButtonClickStyleView(
      state: state,
      frame: fr,
      radius: 26
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
       // secondImageView?.image = state.secondImage
        
  }
}
