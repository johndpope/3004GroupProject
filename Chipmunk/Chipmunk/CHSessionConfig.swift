//
//  STSessionConfig.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation

open class CHSessionConfig {
	
	open var title: String
	open var password: String?
	open var numCells: Int?
	
	open var service: NetService?
	
	public init(title: String, password: String?, service: NetService?) {
		self.title = title
		self.password = password
		
		self.service = service
	}
}
