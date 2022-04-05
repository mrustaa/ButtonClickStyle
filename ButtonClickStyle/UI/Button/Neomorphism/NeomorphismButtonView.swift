import UIKit

class NeomorphismButtonView: BtnView {
  
  @IBOutlet var mainView: UIView!
  @IBOutlet var fillView: DesignableView!
  @IBOutlet private weak var titleLabel: UILabel?
    
  @IBOutlet var backColor: UIView!
  // MARK: Initialize
  
 override func awakeFromNib() { }
  @IBOutlet var cardView: DesignableView!
  
  override func fill(state: BtnCellState?) {
    guard let state = state else { return }
    self.state = state

   mainView.layer.cornerRadius = 14
   
   if let type = state.animationType {

     
     if !state.addBackgrondColor {
       backgroundColor = .clear
       cardView.fillColor = .white
       cardView.setNeedsLayout()
     }
     backColor.isHidden = !state.addBackgrondColor 
     
     let fr: CGRect = .init(x: 25.5, y: 22.5, width: 151, height: 48)
     let radius: CGFloat = 14
     
     var addViews: [UIView]? = [mainView]
//     if (type == 2) || (type == 8) || (type == 9) || (type == 10) {
//       addViews = [fillView]
//     }
     
     if type == ButtonClick.StyleEasy.color.rawValue ||
          (type == ButtonClick.StyleEasy.shadow.rawValue) ||
          (type == ButtonClick.StyleEasy.shadowColor.rawValue )
//          type == ButtonClick.StyleEasy.androidClickable.rawValue ||
//          type == ButtonClick.StyleEasy.androidClickableDark.rawValue
     {
       addViews = [fillView]
     } else if type == ButtonClick.StyleEasy.androidClickable.rawValue ||
                type == ButtonClick.StyleEasy.androidClickableDark.rawValue {
       addViews = nil
     } 
      
     
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
   
     titleLabel?.text = state.titleText
        
  }
}
