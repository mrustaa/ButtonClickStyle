import UIKit





class TestDemoSquaresButtonView: BtnView {
  
  @IBOutlet var mainView: UIView!
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state
    
    if let _ = state.animationType {
      let fr: CGRect = .init(x: 0, y: 0, width: 240, height: 93)
      let viewAn = ButtonClickStyleView(
        state: state,
        frame: fr,
        radius: 0
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
    
    
  }
}
