SwiftFloatingLabelTextField
===========================

For learning Swift, one of the things I did was convert some existing Objective-C tools and ported them over to Swift.  This repository is the result of doing that with [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField).

### Todo
This could be better represented using the [IBDesignable/IBInspectable](http://www.thinkandbuild.it/building-custom-ui-element-with-ibdesignable/) method.  When attempting to do this though, xcode throws errors such as:
* @IBDesignable error: IB Designables: Failed to update auto layout status: Interface Builder Cocoa Touch Tool crashed
* Rendering the view took longer than 200 ms. Your drawing code may suffer from slow performance.

This is more than likely something silly I'm doing, but after having exhausted stackoverflow and numerous walkthroughs on the subject, I decided its just not something I'm capable of doing at this stage.  If some smarter dev would like to add this functionality, by all means do and let me know!
