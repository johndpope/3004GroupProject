//
//  UILabel+StreamIt.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-10-31.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
	
	static func st_flexibleTitleLabel(text: String) -> UILabel {
		let label = UILabel(frame: CGRectZero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFontOfSize(14)
		label.numberOfLines = 0
		label.lineBreakMode = .ByWordWrapping
		label.text = text
		
		return label
	}
	
	static func st_flexibleSubtitleLabel(text: String) -> UILabel {
		let label = UILabel(frame: CGRectZero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFontOfSize(12)
		label.numberOfLines = 0
		label.lineBreakMode = .ByWordWrapping
		label.text = text
		
		return label
	}
	
	static func st_flexibleCenteredLabel(text: String) -> UILabel {
		let label = UILabel(frame: CGRectZero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .Center
		label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
		label.text = text
		
		return label
	}
	
	
}
