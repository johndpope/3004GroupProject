//
//  NSLayoutConstraint+StreamIt.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-10-31.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
	
	// Pins the top of `view` to the bottom of `toView`, and the leading/trailing edges of `view` to its container
	static func constraintsPinning(topOfView: UIView, toBottomOfView: UIView, space: CGFloat) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints.append(NSLayoutConstraint(item: topOfView, attribute: .Top, relatedBy: .Equal, toItem: toBottomOfView, attribute: .Bottom, multiplier: 1, constant: space))
		
		constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": topOfView])
		
		
		return constraints
	}
	
	// Pins the top of 'view' to the top of its container, with an optional space. Also constrains leading/trailing to the container
	static func constraintsPinningViewInsideSuperView(view: UIView, space: CGFloat) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(space)-[view]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		
		constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		
		
		return constraints
	}
	
	// Pins all four sides of 'view' to its super view.
	static func constraintsFillingSuperViewWithView(view: UIView) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints +=  NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["view": view])
		constraints +=  NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["view": view])
		
		return constraints
	}
}
