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
	
	init(placeholder: String) {
		super.init(frame: CGRectZero)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.placeholder = placeholder
		
		self.borderStyle = .None
		self.font = UIFont.systemFontOfSize(18)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.borderStyle = .None
		self.font = UIFont.systemFontOfSize(18)
		
		self.setErrorState(false)
	}
	
	func setErrorState(error: Bool) {
		let color = (error == true) ? UIColor.redColor() : UIColor.appTintColor()
		
		// Connor, 05/17/2016 - We're baisically going to continue to draw
		// over the same line because removing layers causes
		// 'message sent to deallocated instance' issues
		let path = UIBezierPath()
		path.moveToPoint(CGPoint(x: 0, y: self.frame.height - 2))
		path.addLineToPoint(CGPoint(x: self.frame.width, y: self.frame.height - 2))
		
		let shapeLayer = CAShapeLayer()
		shapeLayer.path = path.CGPath
		shapeLayer.strokeColor = color.CGColor
		shapeLayer.lineWidth = 2.0 / UIScreen.mainScreen().scale
		
		self.layer.addSublayer(shapeLayer)
	}
	
	override func drawRect(rect: CGRect) {
		super.drawRect(rect)
		
		self.setErrorState(false)
	}
}
