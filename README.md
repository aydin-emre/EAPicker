# EAPicker

[![CI Status](https://img.shields.io/travis/aydin-emre/EAPicker.svg?style=flat)](https://travis-ci.org/aydin-emre/EAPicker)
[![Version](https://img.shields.io/cocoapods/v/EAPicker.svg?style=flat)](https://cocoapods.org/pods/EAPicker)
[![License](https://img.shields.io/cocoapods/l/EAPicker.svg?style=flat)](https://cocoapods.org/pods/EAPicker)
[![Platform](https://img.shields.io/cocoapods/p/EAPicker.svg?style=flat)](https://cocoapods.org/pods/EAPicker)

![EAAlert example](https://i.ibb.co/WczDRSX/ea-picker.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

EAPicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EAPicker'
```

## How To Use

Firstly, import EAAlert to your project
```swift
import EAPicker
```

After importing EAPicker you will be able to create a picker view either using storyboard or using swift code.

For instance, using storyboard, create an empty view and in Identity Inspector change class name as EAPicker and drag it to your swift class.

Add delegate, set title, and add values.
```swift
picker.setTitle("Title")
picker.values = ["Value 1", "Value 2", "Value 3"]
```
You can set initially selected row
```swift
picker.selectedRow = 1
```
You can hide title
```swift
picker.isTitleHidden = true
```
You can enable or disable picker
```swift
picker.setEnabled(false)
```

## Delegate
Set picker delegate
```swift
picker.delegate = self
```
Add EAPickerDelegate to your view controller, and import necessary functions.
```swift
extension ViewController: EAPickerDelegate {
    
    func didSelectRow(_ pickerView: EAPicker, didSelectRow row: Int) {
        print("************* didSelectRow", row)
    }
    
    func doneButtonPressed(_ pickerView: EAPicker, didSelectRow row: Int) {
        print("************* doneButtonPressed", row)
    }
    
}
```

## Customize
You can change title and value labels' color and font
```swift
picker.titleLabelColor = .red
picker.titleLabelFont = UIFont.boldSystemFont(ofSize: 20)

picker.valueLabelColor = .blue
picker.valueLabelFont = UIFont.systemFont(ofSize: 23)
```

## Author

aydin-emre, www.emr.ee

## License

EAPicker is available under the MIT license. See the LICENSE file for more info.
