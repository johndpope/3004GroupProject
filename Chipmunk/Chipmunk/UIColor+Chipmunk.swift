//
//  NSColor+StreamIt.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-08.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	
	static func appTintColor() -> UIColor {
		return UIColor(red: 1, green: 0.45, blue: 0.0039, alpha: 1)
	}
	
	static func dullGreyColor() -> UIColor {
		return UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
	}
	
	static func gradient1Color() -> UIColor {
		return UIColor(red: 1, green: 0.007, blue: 0, alpha: 1)
	}
	
	static func gradient2Color() -> UIColor {
		return UIColor(red: 1, green: 0.78, blue: 0.039, alpha: 1)
	}
	
	static func gradient1ColorFaded() -> UIColor {
		return UIColor(red: 1, green: 0.007, blue: 0, alpha: 0.5)
	}
	
	static func gradient2ColorFaded() -> UIColor {
		return UIColor(red: 1, green: 0.78, blue: 0.039, alpha: 0.5)
	}
	
	static func darkBackgroundColor() -> UIColor {
		return UIColor(red: 0.256, green: 0.256, blue: 0.256, alpha: 1)
	}
	
	static func mediumForegroundColor() -> UIColor {
		return UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
	}
	
	static func lightForegroundColor() -> UIColor {
		return UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
	}
}
