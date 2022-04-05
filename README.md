# ButtonClickStyle

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/all_ipad_random.gif)

This is a view button

Has 9 styles of animated click

Inside the layer you can style your button, create your own subviews

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
```swift
#type  #name

enum Style {
  # hide
  case alpha                 
  case flash // alpha flicker
  # add
  case shadow                 
  case shadowColor            
  case color                  
  case colorFlat // border text
  # move 
  case pulsateNew             
  case pulsate                
  case press                  
  case shakeNew               
  case shake                  
  # add pulsate 
  case androidClickableDark   
  case androidClickableLigt
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
@IBInspectable var animationType: Int = 
@IBInspectable var animationValue: CGFloat = 0.0
@IBInspectable var animationDuration: CGFloat = 0.0
  
var addViews: [UIView]?
```

7) If initializing programmatically
     - There is a property `addViews` - allows you to pass views / layers
       which you definitely want to use in the click animation only


```swift
let btnView = ButtonClickStyleView(
   frame: @frame,
   animation: @type,
   value: @value,
   addViews: @views,
)
btnView.insertSubview(self.view, at: 0)
btnView.updateSubviews()

```

## Credits


## License

ButtonClickStyle is released under the MIT license.

