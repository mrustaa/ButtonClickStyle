import UIKit


class SearchButtonView: BtnView {
  
  @IBOutlet var mainView: UIView!
  @IBOutlet private weak var titleLabel: UILabel?
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state
    

   if let _ = state.animationType {
     let fr: CGRect = .init(x: 17 , y: 22, width: 168, height: 49)
     let viewAn = ButtonClickStyleView(
      state: state,
      frame: fr,
      radius: 24
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
