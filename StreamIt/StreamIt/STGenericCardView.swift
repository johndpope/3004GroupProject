//
//  STGenericCardView.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-07.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

class STGenericCardView: UIView {
	
	var titleLabel: UILabel!
	
	init(title: String) {
		super.init(frame: CGRectZero)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.layer.borderWidth = 0.7
		self.layer.cornerRadius = 4
		self.layer.borderColor = UIColor.dullGreyColor().CGColor
		
		self.titleLabel = self.generateTitleView(title)
		
		self.addSubview(self.titleLabel)
		self.addConstraints(NSLayoutConstraint.constraintsPinningToTopLeftOfSuperview(self.titleLabel, padding: 15))
		self.layoutSubviews()
	}
	
	func generateTitleView(title: String) -> UILabel {
		let label = UILabel.st_flexibleTitleLabel(title)
		
		return label
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
