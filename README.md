# ButtonClickStyle

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/all_ipad_random.gif)

This is a layer button
Has 9 styles of animated click

Inside the layer you can style your button, create your own subviews

+ You can expand the project
  adding new click-animation-styles

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
```ruby
#type  #name

hide .alpha
hide .flash 
add  .shadow
add  .shadow color
add  .color
add  .color flat (border text)
move .pulsate new
move .pulsate
move .press
move .shake  new
move .shake
add  .androidClickable dark
add  .androidClickable ligt
```

4) Так же вы можете выбрать   анимировать все слои  `allSubviews`  / или только 1 


5) Добавить + animation.Duration - время анимации

6) Добавить + animation.Value    - под значением имеется ввиду  
   у анимации тип   
 - "Hide .Alpha/Flash/Shadow/Color"    будет меняться альфа от 0.0 до 1.0
 - "Move .Pulsate/Press/Shake"         будет движения усиливаться уменьшаться от 0.0 до 1.0
 - "Add  .AndroidClickable"            будет увелмчиваться радиус пузырей


```swift
@IBInspectable var allSubviews: Bool = true
@IBInspectable var animationType: Int = 
@IBInspectable var animationValue: CGFloat = 0.0
@IBInspectable var animationDuration: CGFloat = 0.0
  
var addViews: [UIView]?

```
7) Если иниализацируйие программно 
    - Есть свойство  `addViews` - позволяет передать вьшки/слои 
      которые вы точно захотите задейстовать в анимации нажатия  only


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

