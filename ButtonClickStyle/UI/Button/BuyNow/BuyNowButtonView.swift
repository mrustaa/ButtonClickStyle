import UIKit


class BuyNowButtonView: BtnView {
  
  @IBOutlet var mainView: UIView!
  @IBOutlet var borderView: DesignableView!
  @IBOutlet var textLabel: UILabel!
  
  override func fill(state: BtnCellState?) {
    guard let state = state else { return }
    self.state = state

   if let type = state.animationType {
     
     var views: [UIView]? = [mainView]
     
     if type == ButtonClick.StyleEasy.color.rawValue  {
       views = [borderView, textLabel]
     } else if type == ButtonClick.StyleEasy.androidClickable.rawValue ||
                type == ButtonClick.StyleEasy.androidClickableDark.rawValue {
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
     
     self.animation?.removeFromSuperview()
     self.animation = viewAn
     mainView.origin = .zero
   }
   
     textLabel.text = state.titleText
        
  }
}
