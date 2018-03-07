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
		animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
		animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
		self.layer.add(animation, forKey: "position")
	}
}
