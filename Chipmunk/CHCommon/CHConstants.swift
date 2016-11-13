//
//  CHConCHants.swift
//  CHreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation

public func CHConstBonjourName() -> String {
	return "com.CHreamit.httpserver"
}

public func CHConstBonjourType() -> String {
	return "_CHreamit._tcp"
}

public func CHNotifBonjourServiceAdded() -> String {
	return "com.CHreamit.serviceadded"
}

public func CHNotifBonjourServiceRemoved() -> String {
	return "com.CHreamit.serviceremoved"
}
