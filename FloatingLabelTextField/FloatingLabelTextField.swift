//
//  FloatingLabelTextField.swift
//  SwiftFloatingLabelTextField
//
//  Created by Jonathon Hibbard on 12/18/14.
//  Copyright (c) 2014 Integrated Events. All rights reserved.
//

import UIKit

class FloatingLabelTextField: UITextField {
    let floatingLabel:UILabel = UILabel()
    let floatingLabelTextColor: UIColor = UIColor.grayColor()
    let floatingLabelIsBoundToParent: Bool = false
    let animateEvenIfNotFirstResponder:Bool = false
    let placeholderYPadding:CGFloat = 0.0
    let yPadding:CGFloat = 0.0
    let showAnimationDuration:NSTimeInterval = 0.3
    let hideAnimationDuration:NSTimeInterval = 0.3

    var floatingLabelActiveTextColor: UIColor?
    var animatedYPos:CGFloat = 0.0
    var floatingLabelFont: UIFont = UIFont.boldSystemFontOfSize( 12.0 )

    private override init() {
        super.init()
        commonInit()
    }

    private override init( frame: CGRect ) {
        super.init( frame: frame )
        commonInit()
    }

    required init( coder aDecoder: NSCoder ) {
        super.init( coder: aDecoder )
        commonInit()
    }

    private func commonInit() {
        floatingLabelActiveTextColor = tintColor
        floatingLabel.alpha = 0.0
        floatingLabel.font = floatingLabelFont
        floatingLabel.textColor = floatingLabelTextColor

        setFloatingLabelText( self.placeholder! )
        addSubview( floatingLabel )

        clipsToBounds = floatingLabelIsBoundToParent
        layer.masksToBounds = floatingLabelIsBoundToParent

        if !floatingLabelIsBoundToParent {
            animatedYPos = -15.0
        }
    }

    func setFloatingLabelText( text:String ) {
        floatingLabel.text = text
        self.setNeedsLayout()
    }

    func setFloatingLabelFont( floatingLabelFont:UIFont ) {
        self.floatingLabelFont = floatingLabelFont
        self.placeholder = self.placeholder
    }
    
    func showFloatingLabel( animated:Bool ) {
        let labelFrame = CGRectMake( floatingLabel.frame.origin.x, animatedYPos, floatingLabel.frame.width, floatingLabel.frame.height )

        if animated || animateEvenIfNotFirstResponder {

            UIView.animateWithDuration( self.showAnimationDuration, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.floatingLabel.alpha = 1.0
                self.floatingLabel.frame = labelFrame
            }, completion:nil )

            return
        }

        self.floatingLabel.alpha = 1.0
        self.floatingLabel.frame = labelFrame
    }

    func hideFloatingLabel( animated:Bool ) {

        if animated || self.animateEvenIfNotFirstResponder {
            let yPos = self.floatingLabel.font.lineHeight + self.yPadding

            UIView.animateWithDuration( self.hideAnimationDuration, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.floatingLabel.alpha = 0.0
                self.floatingLabel.frame = CGRectMake( self.floatingLabel.frame.origin.x, yPos, self.floatingLabel.frame.width, self.floatingLabel.frame.height )
            }, completion:nil )

            return
        }

        self.floatingLabel.alpha = 0.0
        self.floatingLabel.frame = CGRectMake( self.floatingLabel.frame.origin.x, self.floatingLabel.font.lineHeight + self.yPadding, self.floatingLabel.frame.width, self.floatingLabel.frame.height )
    }

    func setLabelOriginForTextAlignment() {
        var textRect:CGRect = textRectForBounds( self.bounds )
        var originX = textRect.origin.x

        if self.textAlignment == NSTextAlignment.Center {
            originX = textRect.origin.x + ( textRect.size.width / 2 ) - ( self.floatingLabel.frame.size.width / 2 )
        } else if self.textAlignment == NSTextAlignment.Right {
            originX = textRect.origin.x + textRect.size.width - self.floatingLabel.frame.size.width
        }

        self.floatingLabel.frame = CGRectMake( originX, self.floatingLabel.frame.origin.y, self.floatingLabel.frame.size.width, self.floatingLabel.frame.size.height )
    }

    override func textRectForBounds( bounds:CGRect ) -> CGRect {
        var rect:CGRect = super.textRectForBounds( bounds )

        let text = self.text!

        if countElements(text) > 0 {

            var topInset:CGFloat = CGFloat( ceilf( Float( self.floatingLabel.font.lineHeight + self.placeholderYPadding ) ) )
            topInset = min(topInset, maxTopInset())

            rect = UIEdgeInsetsInsetRect( rect, UIEdgeInsetsMake( topInset, 0.0, 0.0, 0.0 ) )
        }

        return CGRectIntegral( rect )
    }
    
    func setPlaceholder( placeholder:NSString ) {
        super.placeholder = placeholder

        self.floatingLabel.text = placeholder
        self.floatingLabel.sizeToFit()
    }

    func setAttributedPlaceholder( attributedPlaceholder: NSAttributedString ) {
        super.placeholder = placeholder

        self.floatingLabel.text = attributedPlaceholder.string
        self.floatingLabel.sizeToFit()
    }

    func setAttributedPlaceholder( placeholder:NSAttributedString, floatingTitle:NSString ) {
        super.attributedPlaceholder = placeholder

        self.floatingLabel.text = floatingTitle
        self.floatingLabel.sizeToFit()
    }

    override func editingRectForBounds( bounds:CGRect ) -> CGRect {
        var rect:CGRect = super.editingRectForBounds( bounds )
        let text = self.text!

        if countElements( text ) > 0 {
            var topInset:CGFloat = CGFloat( ceilf( Float( self.floatingLabel.font.lineHeight + self.placeholderYPadding ) ) )
            topInset = min(topInset, maxTopInset())

            rect = UIEdgeInsetsInsetRect( rect, UIEdgeInsetsMake( topInset, 0.0, 0.0, 0.0 ) )
        }

        return CGRectIntegral( rect )
    }

    override func clearButtonRectForBounds( bounds:CGRect ) -> CGRect {
        var rect:CGRect = super.clearButtonRectForBounds( bounds )
        let text = self.text!
        
        if countElements( text ) > 0 {

            var topInset:CGFloat = CGFloat( ceilf( Float( self.floatingLabel.font.lineHeight + self.placeholderYPadding ) ) )
            topInset = min( topInset, maxTopInset() )

            rect = CGRectMake( rect.origin.x, rect.origin.y + topInset / 2.0, rect.size.width, rect.size.height )
        }

        return CGRectIntegral( rect )
    }

    func maxTopInset() -> CGFloat {
        let initialValue:CGFloat = 0.0

        return max( initialValue, CGFloat( floorf( Float( self.bounds.size.height - self.font.lineHeight - 4.0 ) ) ) )
    }

    func setTextAlignment( textAlignment:NSTextAlignment ) {
        super.textAlignment = textAlignment

        self.setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setLabelOriginForTextAlignment()
        self.floatingLabel.font = self.floatingLabelFont

        self.floatingLabel.sizeToFit()

        var firstResponder:Bool = self.isFirstResponder()
        let text = self.text!

        if firstResponder && countElements( text ) > 0 {
            self.floatingLabel.textColor = floatingLabelActiveTextColor
        } else {
            self.floatingLabel.textColor = self.floatingLabelTextColor
        }

        if countElements( text ) == 0 {
            hideFloatingLabel( firstResponder )
        } else {
            showFloatingLabel( firstResponder )
        }
    }
}
