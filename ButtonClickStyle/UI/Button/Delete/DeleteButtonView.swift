import UIKit

class DeleteButtonView: BtnView {
  
  @IBOutlet var mainView: UIView!
  @IBOutlet var designImageView: DesignableView!
  @IBOutlet private weak var subtitleLabel: UILabel?
    
  @IBOutlet var backColor: DesignableView!
  
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state
    
   if let _ = state.animationType {
     let fr: CGRect = .init(x: 18 , y: 22, width: 166, height: 49)
     let viewAn = ButtonClickStyleView(
      state: state,
      frame: fr,
      radius: 24
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
//     firstImageView?.image = state.firstImage
//    designImageView?.layer.cornerRadius = 24
        subtitleLabel?.text = state.titleText
        
  }
}
