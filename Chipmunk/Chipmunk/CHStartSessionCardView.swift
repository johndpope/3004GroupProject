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
	
	var startButton: UIButton!
	var controller: CHInitialController!
	
	init(title: String, controller: CHInitialController) {
		super.init(title: title)
		
		self.controller = controller
		
		self.startButton = self.generateStartButton()
		self.addSubview(self.startButton)
		self.addConstraints(self.generateInitialConstraints(self.startButton))
	}
	
	func startServerPressed(sender: UIButton) {
		self.controller.startServerPressed()
	}
	
	func generateStartButton() -> UIButton {
		let butt = UIButton(frame: CGRectZero)
		
		butt.translatesAutoresizingMaskIntoConstraints = false
		butt.setTitle("Start Server", forState: .Normal)
		butt.setTitleColor(UIColor.appTintColor(), forState: .Normal)
		
		butt.addTarget(self, action: #selector(CHStartSessionCardView.startServerPressed(_:)), forControlEvents: .TouchUpInside)
		
		return butt
	}
	
	func generateInitialConstraints(start: UIButton) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints.append(NSLayoutConstraint(item: start, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
		constraints.append(NSLayoutConstraint(item: start, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
		
		return constraints
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
