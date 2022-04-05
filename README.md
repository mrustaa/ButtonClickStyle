# ButtonClickStyle

![image](https://github.com/mrustaa/GifPresentations/blob/master/ButtonClickStyle/all_ipad_random.gif)

Это слой кнопка
 которая имеет 9 стилей анимированного нажатия 

Внутри Слоя 
 можно создавать свои собственные кнопки 
  subviews - с вложенные вьюхами 

+ Можно расширять проект
 добавляя новые стили-анимации-нажатия

## Requirements

macOS 10.12+
Xcode 13+
Swift 5.5+

## Installation


## Usage

#### С storyboard или xib

1) Создайте вьюшку, которая наследуется `ButtonClickStyleView`

<!--You can now style your button (Теперь вы можете стилизовать свою кнопку )-->
2) Внутри этого слоя, создавайте свою собственную кнопку из других слоев 

3) В атрибутых инспектора (`Attributes Inspector` of `Interface Builder`)а
  вы можете сразу выбрать тип анимации нажатия кнопки  `animationType` 
 
  Пока  9 стилей анимированного нажатия 
```swift
#type  #name

"Hide .Alpha"
"Hide .Flash (more)"
"Add  .Shadow"
"Add  .Color"
"Add  .ColorFlat (border text)" 
"Move .Pulsate (new)"
"Move .Pulsate"
"Move .Press"
"Move .Shake (new)"
"Move .Shake"
"Add  .AndroidClickable (dark)"
"Add  .AndroidClickable (ligth)"
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

