//
//  UIButton+StreamIt.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-10-31.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
	
	// I essentially stole this from Stack Overflow, translated it to Swift, and tweaked it for our use case.
	static func backButtonWithTitle(title: String, flexible: Bool) -> UIButton {
		let button = UIButton(type: .Custom)
		button.setTitle(title, forState: .Normal)
		button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		
		button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
		
		if (flexible == true) {
			// This can be used as a regular button...
			button.translatesAutoresizingMaskIntoConstraints = false
		}
		else {
			// ... Or as a custom view for a UIBarButtonItem
			button.frame = CGRect(x: 0, y: 0, width: 100, height: 35)
		}
		
		let backImage = UIImage(named: "backchevron")!
		button.setImage(backImage, forState: .Normal)
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
		
		return button
	}
}
