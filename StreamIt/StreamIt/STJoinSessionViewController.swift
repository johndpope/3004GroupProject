//
//  STJoinSessionViewController.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

class STJoinSessionViewController: UIViewController {
	
	var config: STSessionConfig!
	
	init(config: STSessionConfig) {
		super.init(nibName: nil, bundle: nil)
		
		self.config = config
		
		self.title = self.config.title
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
