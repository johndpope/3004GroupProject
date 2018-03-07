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
	
	static func st_flexibleTitleLabel(_ text: String) -> UILabel {
		let label = UILabel(frame: CGRect.zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 14)
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.text = text
		
		return label
	}
	
	static func st_flexibleSubtitleLabel(_ text: String) -> UILabel {
		let label = UILabel(frame: CGRect.zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 12)
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.text = text
		
		return label
	}
	
	static func st_flexibleCenteredLabel(_ text: String) -> UILabel {
		let label = UILabel(frame: CGRect.zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
		label.text = text
		
		return label
	}
	
	
}
