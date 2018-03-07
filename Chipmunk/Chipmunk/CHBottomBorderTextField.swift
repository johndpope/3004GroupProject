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
		super.init(frame: CGRect.zero)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.placeholder = placeholder
		self.setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setup()
	}
	
	func setup() {
		self.borderStyle = .none
		self.font = UIFont.systemFont(ofSize: 18)
		self.clipsToBounds = true
		self.layer.cornerRadius = 4
		
		self.backgroundColor = UIColor.darkBackgroundColor()
		
		let placeholderString = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.mediumForegroundColor()])
		self.placeholder = ""
		self.attributedPlaceholder = placeholderString
		
		self.delegate = self
		
		self.drawBorder()
	}
	
	fileprivate func drawBorder() {
		if let lay = self.shapeLayer {
			lay.removeFromSuperlayer()
		}
		
		// Connor, 05/17/2016 - We're baisically going to continue to draw
		// over the same line because removing layers causes
		// 'message sent to deallocated instance' issues
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 0, y: self.frame.height - 2))
		path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height - 2))
		
		self.shapeLayer = CAShapeLayer()
		self.shapeLayer!.path = path.cgPath
		self.shapeLayer!.strokeColor = UIColor.appTintColor().cgColor
		self.shapeLayer!.lineWidth = 2.0 / UIScreen.main.scale
		
		self.layer.addSublayer(self.shapeLayer!)
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		self.drawBorder()
	}
}

extension CHBottomBorderTextField: UITextFieldDelegate {
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: 0, dy: 5)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: 0, dy: 5)
	}
}
