//
//  STJoinSessionViewController.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit
import CHCommon

class CHJoinSessionViewController: UIViewController {
	
	var config: CHSessionConfig!
	
	var testLabel: UILabel!
	
	init(config: CHSessionConfig) {
		super.init(nibName: nil, bundle: nil)
		
		self.config = config
		
		self.title = self.config.title
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.whiteColor()
		
		self.testLabel = self.generateTestLabel()
		self.view.addSubview(self.testLabel)
		self.view.addConstraints(self.generateTestLabelConstraints(self.testLabel))
		
		self.view.layoutSubviews()
		
		let APIClient = CHAPIClient(service: self.config.service!)
		APIClient.getRootURLString({(body: String) in
			self.testLabel.text = body
		})
	}
	
	func generateTestLabel() -> UILabel {
		let label = UILabel.st_flexibleTitleLabel("")
		
		return label
	}
	
	func generateTestLabelConstraints(label: UILabel) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints += NSLayoutConstraint.constraintsFillingSuperViewWithView(label)
		
		return constraints
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
