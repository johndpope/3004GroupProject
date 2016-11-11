//
//  UIView+StreamIt.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-10-31.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	
	// Taken from https://rapiddg.com/blog/shaking-animation-swift
	func st_shake() {
		let animation = CABasicAnimation(keyPath: "position")
		animation.duration = 0.07
		animation.repeatCount = 3
		animation.autoreverses = true
		animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 10, self.center.y))
		animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 10, self.center.y))
		self.layer.addAnimation(animation, forKey: "position")
	}
}
