import UIKit

class JustPinkButtonView: BtnView {
  
  // MARK: Outlets
  
  @IBOutlet var fillView: ButtonClickStyleDesignView!
  @IBOutlet var mainView: UIView!
  @IBOutlet var mainShadowView: ButtonClickStyleDesignView!
  @IBOutlet var subMainView: ButtonClickStyleDesignView!
  @IBOutlet var mainDetailsView: ButtonClickStyleDesignView!
  @IBOutlet var gradientView: ButtonClickStyleDesignView!
  @IBOutlet var titleLabel: UILabel!
  
  
  // MARK: Initialize
 
  override func fill(state: ButtonClick.State?) {
     guard let state = state else { return }
     self.state = state

   if let type = state.animationType {
     let fr: CGRect = .init(x: 13 , y: 10, width: 176, height: 56)
     var views: [UIView]? = []
     
     
     if !state.addBackgrondColor {
       backgroundColor = .clear
     }
     
     if state.new {
       let color: UIColor = #colorLiteral(red: 0.568627451, green: 0.2784313725, blue: 1, alpha: 1)
       fillView.fillColor =  #colorLiteral(red: 0.1529411765, green: 0.6823529412, blue: 0.3764705882, alpha: 1).withAlphaComponent(0.08)
       
//       gradientView.isHidden = true
//       gradientView.alpha = 0
       gradientView.isHidden = false
       gradientView.alpha = 1.5
       
       mainDetailsView.fillColor = color
       
       mainDetailsView.grColor1 = #colorLiteral(red: 0.568627451, green: 0.2784313725, blue: 1, alpha: 1)
       mainDetailsView.grColor2 = #colorLiteral(red: 0.568627451, green: 0.7273057943, blue: 1, alpha: 1)
       mainDetailsView.grStartPoint = .init(x: 0, y: 1)
       mainDetailsView.grEndPoint = .init(x: 1, y: 0)
       
       mainShadowView.fillColor = color.withAlphaComponent(0.8)
       mainShadowView.blur = 36
       views = [subMainView]
       
     } else {
       
       fillView.fillColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1).withAlphaComponent(0.55)
       gradientView.isHidden = false
       gradientView.alpha = 1
       mainShadowView.blur = 24
//       gradientView.grColor1 = #colorLiteral(red: 0.568627451, green: 0.2784313725, blue: 1, alpha: 1)
//       gradientView.grColor2 = #colorLiteral(red: 0.568627451, green: 0.8245446441, blue: 1, alpha: 1)
       
       
       mainDetailsView.grColor1 = nil
       mainDetailsView.grColor2 = nil
       
       let color: UIColor = #colorLiteral(red: 0.9215686275, green: 0.2078431373, blue: 0.5058823529, alpha: 1)
       mainDetailsView.fillColor = color
       mainShadowView.fillColor = color.withAlphaComponent(0.58)
       views = [mainView]
     }
     fillView.blur = 20
     
     fillView.layoutSubviews()
     gradientView.layoutSubviews()
     mainShadowView.layoutSubviews()
     mainDetailsView.layoutSubviews()
     
     
     if type == ButtonClick._Style.color.rawValue {
//        type == ButtonClick.Style.androidClickable(0.5, dark: true).indx() ||
//        type == ButtonClick.Style.androidClickable(0.5, dark: false).indx() {
       views = [subMainView]
     }
     if type == ButtonClick._Style.press.rawValue {
       views = [subMainView, mainShadowView]
     }
     if type == ButtonClick._Style.colorFlat.rawValue {
       views = [subMainView, titleLabel]// [mainDetailsView]
     }
    if type == ButtonClick._Style.androidClickable.rawValue ||
              type == ButtonClick._Style.androidClickableDark.rawValue {
//       views = nil
      views = [subMainView]
     }
     if type == ButtonClick._Style.fave.rawValue {
       views = [mainDetailsView, gradientView]
     }
     
     mainDetailsView.setNeedsLayout()
     mainShadowView.setNeedsLayout()
     
     fillView.isHidden = !state.addBackgrondColor
     
     let viewAn = ButtonClickStyleView(
      state: state,
      frame: fr,
      radius: 8,
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
   
     titleLabel?.text = state.titleText
        
  }
}
