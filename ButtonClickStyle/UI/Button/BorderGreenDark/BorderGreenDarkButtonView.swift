import UIKit

class BorderGreenDarkButtonView: BtnView {
    
  @IBOutlet var mainView: UIView!
  @IBOutlet var borderGradientView: DesignableView!
  @IBOutlet var borderView: DesignableView!
  @IBOutlet var textLabel: UILabel!
  
  @IBOutlet var backColor: UIView!
  
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
      
      if !state.addBackgrondColor {
        backgroundColor = .clear
      }
      backColor.isHidden = !state.addBackgrondColor
      
      let fr: CGRect = .init(x: 33 , y: 21, width: 135, height: 51)
      let viewAn = ButtonClickStyleView(
        state: state,
        frame: fr,
        radius: 2,
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

