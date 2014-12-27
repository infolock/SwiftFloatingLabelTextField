SwiftFloatingLabelTextField
===========================

For learning Swift, one of the things I did was convert some existing Objective-C tools and ported them over to Swift.  This repository is the result of doing that with [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField).

### Usage
Usage is pretty simple.   Just add FloatingLabelTextField.swift to your project, and then either set the custom class for a UITextField in Interface Builder to be FloatingLabelTextField, or create it programatically `let textField = FloatingLabelTextField( frame: CGRectMake( 0, 0, 320.0, 44.0 ) )`

### Property Definitions
Here is a quick breakdown of the current properties:
`floatingLabel:UILabel`
*The actual label that will be floated above a textfield*

`floatingLabelTextColor: UIColor`
*The Default color of the floatingLabel while it is still a "placeholder"*

`floatingLabelIsBoundToParent:Bool`
*When set to `true`, the label will be shown "inside" of the textfield when it is "floating".  False will have the label float "above" the textfield instead.  By default, this is set to false (for my own preference)

`placeholderYPadding:CGFloat`
*The amount of padding to apply to the floatingLabel's Y-Position when it is floated.  This will change based on the `floatingLabelIsBoundToParent` value.*

`yPadding:CGFloat`
*The Amount of padding applied to the UITextField itself.  This is only used when `floatingLabelIsBoundToParent` is set to true (in order to make room for the floatingLabel)

`showAnimationDuration`
*The duration of the animation when "showing" the floatingLabel*

`hideAnimationDuration:NSTimeInterval`
*The duration of the animation when "hiding" the floatingLabel*

`floatingLabelActiveTextColor:UIColor`
*The color of the floatingLabel when it is in floated display mode (rather than placeholder)*

`animatedYPos:CGFloat`
*The Y-Position that the floatedLabel should be animated to when transitioning from placeholder to floated display mode*

`floatingLabelFont:UIFont`
*The font to use for the floatedLabel*

### Todo
This could be better represented using the [IBDesignable/IBInspectable](http://www.thinkandbuild.it/building-custom-ui-element-with-ibdesignable/) method.  When attempting to do this though, xcode throws errors such as:
* @IBDesignable error: IB Designables: Failed to update auto layout status: Interface Builder Cocoa Touch Tool crashed
* Rendering the view took longer than 200 ms. Your drawing code may suffer from slow performance.

This is more than likely something silly I'm doing, but after having exhausted stackoverflow and numerous walkthroughs on the subject, I decided its just not something I'm capable of doing at this stage.  If some smarter dev would like to add this functionality, by all means do and let me know!
