

import UIKit

//MARK: -  ButtonProgram ViewController


class ButtonProgramViewController: StoryboardController {
  
  var prgmButtonClickStyleView: ButtonClickStyleView?
  var prgmFigureView: UIView!
  var prgmRectangleView: UIView!
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Init Programmatically"
    
    
    createProgrammaticaly(type: 2) { event in
      
    }
    
    self.prgmButtonClickStyleView?.update(animationType: 1, allSubviews: true)
    
    self.prgmButtonClickStyleView?.click = { event in
      
    }
  }
  

  func createProgrammaticaly(type: Int = 0, clickAt: ButtonClick.ClosureEvent? = nil) {
    
    let figureView = UIView(frame: .init(x: 50, y: 10, width: 80, height: 40))
    figureView.backgroundColor = .green
    figureView.layer.cornerRadius = 20
    self.prgmFigureView = figureView
    
    let rectangleView = UIView(frame: .init(x: 15, y: 50, width: 50, height: 60))
    rectangleView.backgroundColor = .systemPurple
    self.prgmRectangleView = rectangleView
    
    let state = ButtonClick.State(
      titleText: "Hello",
      allSubviews: true,
      animationType: type,
      animationTypeValue: 0.5,
      animationDuration: nil,
      new: false,
      color: UIColor.green,
      startClick: true,
      debugButtonShow: false,
      addBackgrondColor: true
    )
    
    let btnView = ButtonClickStyleView(
      state: state,
      frame: .init(x: 0, y: 200, width: 240, height: 128),
      radius: 20,
      addViews: [figureView],
      click: { event in
        
      }
    )
    btnView.backgroundColor = .yellow.withAlphaComponent(0.5)
    
    btnView.updateSubviews()
    self.prgmButtonClickStyleView = btnView
    
    btnView.addSubview(figureView)
    btnView.addSubview(rectangleView)
    self.view.addSubview(btnView)
  }
}
