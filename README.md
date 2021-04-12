# ALLatexView
SwiftUI Math equation rendering with Katex

[![Version](https://img.shields.io/cocoapods/v/ALLatexView.svg?style=flat)](https://cocoapods.org/pods/ALLatexView)
[![License](https://img.shields.io/cocoapods/l/ALLatexView.svg?style=flat)](https://cocoapods.org/pods/ALLatexView)
[![Platform](https://img.shields.io/cocoapods/p/ALLatexView.svg?style=flat)](https://cocoapods.org/pods/ALLatexView)

用于显示LaTeX格式文本, 控件实际上包装了WKWebView, 并使用KaTeX进行渲染.

## Example

To run the example project, clone the repo, and run `pod install` from the ExampleSwiftUI directory first.

## Requirements

## Installation

ALLatexView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ALLatexView'
```

## Usage

```swift
public init(_ latex:Binding<String>, height: Binding<CGFloat?> = Binding.constant(nil), css:String = ".formula-wrap {line-height: 24px;}")
```
LatexView() 可接受三个参数:

* latex: 需要渲染的文本，其中的数学公式部分可以用\$latexString\$插入行内公式、或者用\$\$latexString\$\$加入独立公式
* height: 需要动态调整控件高度时, 控件在latex内容更新后会计算并写入新的内容高度. 不需要动态布局时可忽略该参数
* css: Katex渲染文本时使用的样式

## Author

Alfred Gao, alfredg@alfredg.org

## License

ALLatexView is available under the MIT license. See the LICENSE file for more info.
