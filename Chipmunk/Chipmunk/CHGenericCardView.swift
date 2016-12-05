//
//  STGenericCardView.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-07.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

class CHGenericCardView: UIView {
	
	var titleLabel: UILabel!
	
	init(title: String) {
		super.init(frame: CGRectZero)
		
		self.setup(title)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setup(nil)
	}
	
	func setup(title: String?) {
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.layer.cornerRadius = 4
		self.clipsToBounds = true
		
		self.backgroundColor = UIColor.darkBackgroundColor()
		
		self.titleLabel = self.generateTitleView((title != nil) ? title! : "")
		
		self.addSubview(self.titleLabel)
		self.addConstraints(NSLayoutConstraint.constraintsPinningToTopLeftOfSuperview(self.titleLabel, padding: 15))
		self.layoutSubviews()
	}
	
	func generateTitleView(title: String) -> UILabel {
		let label = UILabel.st_flexibleTitleLabel(title)
		label.textColor = UIColor.lightForegroundColor()
		label.font = UIFont.boldSystemFontOfSize(18)
		
		return label
	}
}
