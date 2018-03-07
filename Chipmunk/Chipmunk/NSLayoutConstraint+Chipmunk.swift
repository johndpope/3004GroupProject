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
	static func constraintsPinning(_ topOfView: UIView, toBottomOfView: UIView, space: CGFloat) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints.append(NSLayoutConstraint(item: topOfView, attribute: .top, relatedBy: .equal, toItem: toBottomOfView, attribute: .bottom, multiplier: 1, constant: space))
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": topOfView])
		
		
		return constraints
	}
	
	// Pins the top of 'view' to the top of its container, with an optional space. Also constrains leading/trailing to the container
	static func constraintsPinningViewInsideSuperView(_ view: UIView, topSpace: CGFloat) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(topSpace)-[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		
		
		return constraints
	}
	
	// Pins the top of 'view' to the top of its container, with an optional space. Also constrains leading/trailing to the container
	static func constraintsPinningViewInsideSuperView(_ view: UIView, topSpace: CGFloat, sideSpace: CGFloat) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(topSpace)-[view]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(sideSpace)-[view]-\(sideSpace)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		
		
		return constraints
	}
	
	static func constraintsPinningViewInsideSuperViewBottom(_ view: UIView, space: CGFloat) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-\(space)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(space)-[view]-\(space)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		
		
		return constraints
	}
	
	// Pins all four sides of 'view' to its super view.
	static func constraintsFillingSuperViewWithView(_ view: UIView) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints +=  NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["view": view])
		constraints +=  NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["view": view])
		
		return constraints
	}
	
	// Pins all four sides of 'view' to its super view.
	static func constraintsFillingSuperViewWithView(_ view: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints +=  NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding)-[view]-\(padding)-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["view": view])
		constraints +=  NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[view]-\(padding)-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["view": view])
		
		return constraints
	}
	
	
	static func constraintsPinningToTopLeftOfSuperview(_ view: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints +=  NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding)-[view]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		constraints +=  NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[view]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view])
		
		return constraints
	}
}
