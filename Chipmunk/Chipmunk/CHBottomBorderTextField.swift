//
//  OPSetupBottomBorderTextField.swift
//  OnePasswordiOS
//
//  Created by Connor MacBook on 2016-03-23.
//  Copyright © 2016 AgileBits. All rights reserved.
//
//  - This class is a custom text field styled for the new vault setup strategy with a blue bottom border.

import Foundation
import UIKit

class CHBottomBorderTextField: UITextField {
	
	var shapeLayer: CAShapeLayer?
	
	init(placeholder: String) {
		super.init(frame: CGRectZero)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.placeholder = placeholder
		self.setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setup()
	}
	
	func setup() {
		self.borderStyle = .None
		self.font = UIFont.systemFontOfSize(18)
		self.clipsToBounds = true
		self.layer.cornerRadius = 4
		
		self.backgroundColor = UIColor.darkBackgroundColor()
		
		let placeholderString = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.mediumForegroundColor()])
		self.placeholder = ""
		self.attributedPlaceholder = placeholderString
		
		self.delegate = self
		
		self.drawBorder()
	}
	
	private func drawBorder() {
		if let lay = self.shapeLayer {
			lay.removeFromSuperlayer()
		}
		
		// Connor, 05/17/2016 - We're baisically going to continue to draw
		// over the same line because removing layers causes
		// 'message sent to deallocated instance' issues
		let path = UIBezierPath()
		path.moveToPoint(CGPoint(x: 0, y: self.frame.height - 2))
		path.addLineToPoint(CGPoint(x: self.frame.width, y: self.frame.height - 2))
		
		self.shapeLayer = CAShapeLayer()
		self.shapeLayer!.path = path.CGPath
		self.shapeLayer!.strokeColor = UIColor.appTintColor().CGColor
		self.shapeLayer!.lineWidth = 2.0 / UIScreen.mainScreen().scale
		
		self.layer.addSublayer(self.shapeLayer!)
	}
	
	override func drawRect(rect: CGRect) {
		super.drawRect(rect)
		
		self.drawBorder()
	}
}

extension CHBottomBorderTextField: UITextFieldDelegate {
	
	override func textRectForBounds(bounds: CGRect) -> CGRect {
		return CGRectInset(bounds, 0, 5)
	}
	
	override func editingRectForBounds(bounds: CGRect) -> CGRect {
		return CGRectInset(bounds, 0, 5)
	}
}
