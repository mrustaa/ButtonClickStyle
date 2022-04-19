

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/header.png)
![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/preview_10sec33fps.gif)

# ButtonClickStyle

[![Platform](https://img.shields.io/cocoapods/p/ButtonClickStyle.svg?style=flat)](https://cocoapods.org/pods/ButtonClickStyle)
[![Version](https://img.shields.io/cocoapods/v/ButtonClickStyle.svg?style=flat)](https://cocoapods.org/pods/ButtonClickStyle)
[![Xcode](https://img.shields.io/badge/Xcode-13-blue.svg)](https://developer.apple.com/xcode) 
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org/)
[![Swift 5.2](https://img.shields.io/badge/Swift-5.5-orange.svg?style=flat)](https://swift.org/)
[![License](https://img.shields.io/github/license/almazrafi/Fugen.svg)](https://github.com/mrustaa/ButtonClickStyle/LICENSE)

- This is a customizable/designable Button View, 
- with 15 animated click styles, 
- that allows you to design your own buttons from subviews, 
- in storyboard and xib right away.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

## Watch video with examples

[▶️ Xcode Create in Storyboard/Xib](https://youtu.be/VNupvYMYPmk)

[▶️ Styling Buttons TableList in iPhone](https://youtu.be/OjpMy_LUCIU) 

[![ Xcode Create Storyboard/Xib](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/XcodeCreateXib40.png)](https://youtu.be/VNupvYMYPmk)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

- [Requirements](#requirements)
- [Installation](#installation)
  - [CocoaPods](#cocoapods)
  - [Swift Package Manager](#swift-package-manager)
- [Getting Started](#getting-started)
  - [Usage `ButtonClickStyleView`](#usage-buttonclickstyleview)
    - [Designable Attributes Storyboard/Xib files](#designable-attributes-storyboardxib-files)
  - [Init Programmatically](#init-programmatically)
    - [Addition `ButtonClickStyleDesignView`](#addition-buttonclickstyledesignview)
  - [Button Click/Action Closure](#button-clickaction-closure)
- [Author](#author)
- [License](#license)


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

## Requirements

- Xcode 13+
- iOS 9.0+
- Swift 5.5+

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

## Installation 

### CocoaPods

ContainerControllerSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ButtonClickStyle'
```

### Swift Package Manager

Select Xcode menu `File > Add Packages...` and paste in the repository URL, enter.

Follow [this doc](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

```swift
https://github.com/mrustaa/ButtonClickStyle
```



<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

## Getting Started 

### Usage `ButtonClickStyleView`

#### Designable Attributes Storyboard/Xib files

1) Create a `UIView` that inherits from `ButtonClickStyleView`

2) Inside this View, create design your own button from subviews

3) In Attributes Inspector of Interface Builder,
   you can immediately select the button click style `animType`

   - IBDesignable ...... | `animType` ........ | Number Value | Init Interface Builder
   - ButtonClick.State | `animationType` | Number Value | Init Programmatiсaly State
   - ButtonClick.State | `animationStyle` | Style Value | Init Programmatiсaly State

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/click_styles_example_2x_10sec33fps.gif)

```swift
extension ButtonClick {  
  //                          Number Value
  enum Style {                
    case alpha                //  0
    case flash                //  1
    case shadow               //  2
    case shadowColor          //  3
    case color                //  4
    case colorFlat            //  5
    case pulsateNew           //  6
    case pulsate              //  7
    case press                //  8
    case shake                //  9
    case shakeNew             // 10
    case androidClickable     // 11
    case androidClickableDark // 12
    case fave                 // 13
    case glare                // 14
  }
}  
```

4) Also you can select specific subviews to animate / or just 1 specific one-view `allSubviews`

5) Add animation duration `animDuration`

6) Add animation value `animValue` -  meaning means for some types - alpha or power

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

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

#### Addition `ButtonClickStyleDesignView`

Also you can use in special custom Designable `ButtonClickStyleDesignView` or `ButtonClickStyleDesignLabel` 
   with bunch of options, adding 
   + cornerRadius 
   + figure type 
   + gradient 
   + shadows 
   + borders 
   + blur
   + etc

<!-- ![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/ui3.gif) -->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

### Init Programmatically

If initializing programmatically
There is a property `addViews` - allows you to pass views / layers
which you definitely want to use in the click animation only

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

#### Usage `ButtonClick.State`

Or initialize through a struct `ButtonClick.State`

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
      addViews: [figureView],    // addViews - allows you to pass views / layers which you definitely want to use in the click animation only
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
```

For an already created ButtonView to update the animation type

```swift
 self.prgmButtonClickStyleView?.update(animationType: type, allSubviews: true)
```

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

### Button Click/Action Closure

Add at init programmatically Button Action-Closure event 

```swift
 let btnView = ButtonClickStyleView(
      state: state, 
      frame: frame,
      click: { event in
          ... 
      }
    )
```

Or define Action-Closure after

```swift
 self.prgmButtonClickStyleView?.click = { event in
    ...  
 }
```

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/ui3.gif)

## Author

<motionrustam@gmail.com> 📩| [mrustaa](https://github.com/mrustaa/)

## License

ButtonClickStyle is released under the MIT license.

