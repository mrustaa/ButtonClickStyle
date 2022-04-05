# ButtonCustomButtonClickStyle

Это слой кнопка
 которая имеет 8 стилей анимированного нажатия 

Внутри Слоя 
 можно создавать свои собственные кнопки 
  subviews - с вложенные вьюхами 

+ Можно расширять проект
 добавляя новые стили-анимации-нажатия

## Requirements

- iOS 8.0+
- Xcode 9+

## Installation

For manual instalation, drag Source folder into your project.

os use [CocoaPod](https://cocoapods.org) adding this line to you `Podfile`:

```ruby
pod 'ButtonCustomButtonClickStyle'
```

for [Carthage](https://github.com/Carthage/Carthage) users, add this line to you `Cartfile`

```ruby
github "mrustaa/ButtonCustomButtonClickStyle"
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/sparrowcode/SPQRCode", .upToNextMajor(from: "1.0.4"))
]
```


### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 11+ is required to build Harbeth using Swift Package Manager.

To integrate Harbeth into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yangKJ/Harbeth", .upToNextMajor(from: "0.1.15")),
]
```



## Usage

#### With storyboard or xib files

1) Create a Button that inherits from `Button`

2) Add Image for a `Normal` state

3) Set the `IBOutlet` delegate property to a subclass of `ButtonDelegate`

4) ___Optional___ manipulate porperties to change button settings

```swift
@IBInspectable public var normalColor:     UIColor
@IBInspectable public var selectedColor:   UIColor
@IBInspectable public var dotFirstColor:   UIColor
@IBInspectable public var dotSecondColor:  UIColor
@IBInspectable public var circleFromColor: UIColor
@IBInspectable public var circleToColor:   UIColor
```

## Credits


## License

ButtonCustomButtonClickStyle is released under the MIT license.

