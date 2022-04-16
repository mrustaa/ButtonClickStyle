# ButtonClickStyle


[![Version](https://img.shields.io/cocoapods/v/ButtonClickStyle.svg?style=flat)](https://cocoapods.org/pods/ButtonClickStyle)
[![License](https://img.shields.io/cocoapods/l/ButtonClickStyle.svg?style=flat)](https://cocoapods.org/pods/ButtonClickStyle)
[![Platform](https://img.shields.io/cocoapods/p/ButtonClickStyle.svg?style=flat)](https://cocoapods.org/pods/ButtonClickStyle)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org/)
[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://swift.org/)
[![Swift 5.2](https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat)](https://swift.org/)

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/preview_10sec33fps.gif)

- This is a customizable designable button view/leayr.
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

#### С storyboard или xib

1) Create a "view" that inherits from `ButtonClickStyleView`

2) Inside this layer, create your own button

3) In Attributes Inspector of Interface Builder
   you can immediately select the button click style `animationType`


![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/click_styles_example_2x_10sec33fps.gif)

```swift
extension ButtonClick {
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

6) Add animation value `animationTypeValue` - meaning means
- "Hide .Alpha/Flash/Shadow/Color"  - will change alpha from 0.0 to 1.0
- "Move .Pulsate/Press/Shake"       - will increase movement decrease from 0.0 to 1.0
- "Add  .AndroidClickable"          - will increase bubble radius


```swift
@IBInspectable var allSubviews: Bool = true
@IBInspectable var animationType: Int = 0
@IBInspectable var animationValue: CGFloat = 0.0
@IBInspectable var animationDuration: CGFloat = 0.0
  
var addViews: [UIView]?
```

<!-- ![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/ui3.gif) -->

7) If initializing programmatically
There is a property `addViews` - allows you to pass views / layers
which you definitely want to use in the click animation only

```swift
@IBOutlet var mainView: UIView!

var views: [UIView]? = [mainView]
let frame: CGRect = .init(x: 23 , y: 22, width: 156, height: 48)
let viewAn = ButtonClickStyleView(
   state: state,
   frame: frame,
   radius: 20,
   addViews: views
 )
btnView.insertSubview(mainView, at: 0)
btnView.updateSubviews()

```


8) Or initialize through a struct `ButtonClick.State`

```swift
extension ButtonClick {
  struct State: Equatable {
    var titleText: String?
    var allSubviews: Bool = true
    var animationType: Int?
    var animationTypeValue: CGFloat?
    var animationDuration: CGFloat?
    var new: Bool = false
    var color: UIColor?
    var startClick: Bool = false
    var debugButtonShow: Bool = false
    var addBackgrondColor: Bool = true
  }
}
```

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/ui3.gif)

## License

ButtonClickStyle is released under the MIT license.

