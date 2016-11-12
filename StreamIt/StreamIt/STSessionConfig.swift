//
//  STSessionConfig.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation

class STSessionConfig {
	
	var title: String
	var service: NSNetService
	
	
	init(title: String, service: NSNetService) {
		self.title = title
		self.service = service
	}
}
