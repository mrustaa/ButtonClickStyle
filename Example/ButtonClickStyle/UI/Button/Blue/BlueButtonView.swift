import UIKit


class BlueButtonView: BtnView {
  
  @IBOutlet var mainView: ButtonClickStyleDesignView!
  @IBOutlet private weak var titleLabel: UILabel?
    
  @IBOutlet var backColor: ButtonClickStyleDesignView!
  override func fill(state: ButtonClick.State?) {
     guard let state = state else { return }
     self.state = state

    
    if !state.addBackgrondColor {
      backgroundColor = .clear
    }
    backColor.isHidden = !state.addBackgrondColor
    
   if let _ = state.animationType {
     let fr: CGRect = .init(x: 28, y: 22, width: 146, height: 49)
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
     
     self.btnClickStyleView?.removeFromSuperview()
     self.btnClickStyleView = viewAn
     
     
     var frr = mainView.frame;frr.origin = .zero;mainView.frame = frr
   }
   
     titleLabel?.text = state.titleText
        
  }
}



