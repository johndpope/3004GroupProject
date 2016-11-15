//
//  STStartSessionCardView.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-12.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

class CHStartSessionCardView: CHGenericCardView {
	
	var controller: CHInitialController!
	
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var passField: UITextField!
	var startButton: UIButton!
	
	static func buildFromNib(title: String, controller: CHInitialController) -> CHStartSessionCardView {
		let nib = UINib(nibName: "CHStartSessionCardView", bundle: nil).instantiateWithOwner(nil, options: nil)
		let card = nib.first as! CHStartSessionCardView
		
		card.controller = controller
		card.titleLabel.text = title
		
		card.configureStartButton()
		
		return card
	}
	
	func configureStartButton() {
		self.startButton = UIButton(frame: CGRectZero)
		self.startButton.translatesAutoresizingMaskIntoConstraints = false
		self.startButton.setTitleColor(UIColor.darkBackgroundColor(), forState: .Normal)
		self.startButton.setTitle("Start 🐿", forState: .Normal)
		self.startButton.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
		self.startButton.layer.cornerRadius = 4
		self.startButton.backgroundColor = UIColor.appTintColor()
		self.startButton.addTarget(self, action: #selector(CHStartSessionCardView.startSessionPressed), forControlEvents: .TouchUpInside)
		
		self.addSubview(self.startButton)
		
		self.addConstraint(NSLayoutConstraint(item: self.startButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.startButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: -20))
		self.addConstraint(NSLayoutConstraint(item: self.startButton, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: -30))
		
		self.layoutSubviews()
	}
	
	func startSessionPressed() {
		self.controller.startSessionPressed(self.nameField.text!, password: self.passField.text!)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
