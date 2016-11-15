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
	
	static func buildFromNib(title: String, controller: CHInitialController) -> CHStartSessionCardView {
		let nib = UINib(nibName: "CHStartSessionCardView", bundle: nil).instantiateWithOwner(nil, options: nil)
		let card = nib.first as! CHStartSessionCardView
		
		card.controller = controller
		card.titleLabel.text = title
		
		return card
	}
	
	@IBAction func startSessionPressed() {
		self.controller.startSessionPressed(self.nameField.text!, password: self.passField.text!)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
