import UIKit


class BuyNowButtonView: BtnView {
  
  @IBOutlet var mainView: UIView!
  @IBOutlet var borderView: ButtonClickStyleDesignView!
  @IBOutlet var textLabel: UILabel!
  
  override func fill(state: ButtonClick.State?) {
    guard let state = state else { return }
    self.state = state

   if let type = state.animationType {
     
     var views: [UIView]? = [mainView]
     
     if type == ButtonClick._Style.color.rawValue  {
       views = [borderView, textLabel]
     } else if type == ButtonClick._Style.androidClickable.rawValue ||
                type == ButtonClick._Style.androidClickableDark.rawValue {
       views = nil
     }
     
     let fr: CGRect = .init(x: 23 , y: 22, width: 156, height: 48)
     let viewAn = ButtonClickStyleView(
      state: state,
      frame: fr,
      radius: 20,
      addViews: views
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
   
     textLabel.text = state.titleText
        
  }
}
