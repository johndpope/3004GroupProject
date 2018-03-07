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
	
	static func buildFromNib(_ title: String, controller: CHInitialController) -> CHStartSessionCardView {
		let nib = UINib(nibName: "CHStartSessionCardView", bundle: nil).instantiate(withOwner: nil, options: nil)
		let card = nib.first as! CHStartSessionCardView
		
		card.controller = controller
		card.titleLabel.text = title
		
		card.nameField.textColor = UIColor.white
		card.nameField.delegate = card
		card.passField.textColor = UIColor.white
		card.passField.delegate = card
		
		card.configureStartButton()
		
		return card
	}
	
	func configureStartButton() {
		self.startButton = UIButton(frame: CGRect.zero)
		self.startButton.translatesAutoresizingMaskIntoConstraints = false
		self.startButton.setTitleColor(UIColor.darkBackgroundColor(), for: UIControlState())
		self.startButton.setTitle("Start 🐿", for: UIControlState())
		self.startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
		self.startButton.layer.cornerRadius = 4
		self.startButton.backgroundColor = UIColor.appTintColor()
		self.startButton.addTarget(self, action: #selector(CHStartSessionCardView.startSessionPressed), for: .touchUpInside)
		
		self.addSubview(self.startButton)
		
		self.addConstraint(NSLayoutConstraint(item: self.startButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.startButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20))
		self.addConstraint(NSLayoutConstraint(item: self.startButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -30))
		
		self.layoutSubviews()
	}
	
	func startSessionPressed() {
		if (self.nameField.text == "") {
			self.nameField.st_shake()
			return
		}
		
		self.controller.startSessionPressed(self.nameField.text!, password: self.passField.text!)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

extension CHStartSessionCardView: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if (textField == self.nameField) {
			self.passField.becomeFirstResponder()
		}
		else {
			self.startSessionPressed()
		}
		
		return false
	}
}
