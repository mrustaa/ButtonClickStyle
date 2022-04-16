# ButtonClickStyle


[![Version](https://img.shields.io/cocoapods/v/ButtonClickStyle.svg?style=flat)](https://cocoapods.org/pods/ButtonClickStyle)
[![License](https://img.shields.io/cocoapods/l/ButtonClickStyle.svg?style=flat)](https://cocoapods.org/pods/ButtonClickStyle)
[![Platform](https://img.shields.io/cocoapods/p/ButtonClickStyle.svg?style=flat)](https://cocoapods.org/pods/ButtonClickStyle)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org/)
[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://swift.org/)
[![Swift 5.2](https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat)](https://swift.org/)

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/preview_10sec33fps.gif)

- This is a customizable designable button view/layer.
- Inside the layer you can style your button, create your own subviews.
- Can choose 1 of 15 button click animation styles.
- You can expand the project adding new click-animation-styles.

## Requirements

- macOS 10.12+
- Xcode 13+
- Swift 5.5+


## Installation 

### CocoaPods

ContainerControllerSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ButtonClickStyle'
```

## Usage

#### With storyboard or xib files

1) Create a "view" that inherits from `ButtonClickStyleView`

2) Inside this layer, create your own button

3) In Attributes Inspector of Interface Builder
   you can immediately select the button click style `animationType`

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/click_styles_example_2x_10sec33fps.gif)

```swift
extension ButtonClick {  // animationType
  enum Style {
    case alpha
    case flash
    case shadow
    case shadowColor
    case color
    case colorFlat
    case pulsateNew
    case pulsate
    case press
    case shake
    case shakeNew
    case androidClickable
    case androidClickableDark
    case fave
    case glare
  }
}  
```

4) Also you can select specific layers to animate / or just 1 specific one `allSubviews`

5) Add animation duration `animationDuration`

6) Add animation value `animationTypeValue` -  meaning means for some types - alpha or power

- Hide 
   .Alpha / .Flash         
   Will change alpha for "self.view" from 0.0 to 1.0

- Add       
   .Shadow / .Color / .ColorFlat
   Will change alpha for "add.view" from 0.0 to 1.0

- Move       
   .Pulsate / .Press / .Shake   
   Will change the strength of movement for "self.view" from 0.0 to 1.0

- Tap Gesture 
   .Fave / .AndroidClickable 
   Will increase bubble radius for "add.view"

- Loading   
   .Glare               
   No change for "add.view"

<!-- ![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/ui3.gif) -->

## Init Programmatically

7) If initializing programmatically
There is a property `addViews` - allows you to pass views / layers
which you definitely want to use in the click animation only

8) Or initialize through a struct `ButtonClick.State`

```swift
import ButtonClickStyle
import UIKit

class ViewController: UIViewController {
  
  //MARK: Init Xib/Storyboards
  
  @IBOutlet var xibButtonClickStyleView: ButtonClickStyleView?
  
  //MARK: Init Programmaticaly
  
  var prgmButtonClickStyleView: ButtonClickStyleView?
  var prgmFigureView: UIView!
  var prgmRectangleView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let figureView = UIView(frame: .init(x: 50, y: 10, width: 80, height: 40))
    figureView.backgroundColor = .systemIndigo
    figureView.layer.cornerRadius = 20
    self.prgmFigureView = figureView
    
    let rectangleView = UIView(frame: .init(x: 15, y: 50, width: 50, height: 60))
    rectangleView.backgroundColor = .systemPurple
    self.prgmRectangleView = rectangleView
    
    let state = ButtonClick.State(
      titleText: "Hello",       // debug text button
      allSubviews: true,        // click animation all subviews 
      animationType: 2,         // style 15 
      animationTypeValue: 0.5,  // value - alpha/power move
      animationDuration: nil,   // anim duration
      new: false,               // same styles one of them new 
      color: UIColor.green,     // value color for styles shadowColor/color/colorFlat 
      startClick: true,         // animate on creation
      debugButtonShow: false,   // debug highlight the real button inside
      addBackgrondColor: true   // debug add background color/view
    )
    
    let btnView = ButtonClickStyleView(
      state: state,
      frame: .init(x: 0, y: 300, width: 240, height: 128),
      radius: 20,
      addViews: [figureView]    // addViews - allows you to pass views / layers which you definitely want to use in the click animation only
    )
    btnView.backgroundColor = .yellow.withAlphaComponent(0.5)
    
    btnView.updateSubviews()
    self.prgmButtonClickStyleView = btnView
    
    btnView.addSubview(figureView)
    btnView.addSubview(rectangleView)
    self.view.addSubview(btnView)
  }
}
```

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/ui3.gif)

## Author

<motionrustam@gmail.com> 📩| [mrustaa](https://github.com/mrustaa/)

## License

ButtonClickStyle is released under the MIT license.

