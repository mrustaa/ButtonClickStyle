# ButtonClickStyle

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/preview_10sec33fps.gif)

This is a customizable view layer button
Inside the layer you can style your button, create your own subviews
Has 9 styles of animated click
You can expand the project adding new click-animation-styles

## Requirements

- macOS 10.12+
- Xcode 13+
- Swift 5.5+

## Installation

## Usage

#### С storyboard или xib

1) Create a "view" that inherits from `ButtonClickStyleView`

2) Inside this layer, create your own button

3) In Attributes Inspector of Interface Builder
   you can immediately select the button click `animationType`


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
    var addBackgrondColor: Bool = true
  }
}
```

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/ui3.gif)

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

## License

ButtonClickStyle is released under the MIT license.

