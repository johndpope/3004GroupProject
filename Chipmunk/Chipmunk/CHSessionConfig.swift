//
//  STSessionConfig.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation

public class CHSessionConfig {
	
	public var title: String
	public var password: String?
	public var numCells: Int?
	
	public var service: NSNetService?
	
	public init(title: String, password: String?, service: NSNetService?) {
		self.title = title
		self.password = password
		
		self.service = service
	}
}
