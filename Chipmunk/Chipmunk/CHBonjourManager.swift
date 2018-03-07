//
//  STBonjourManager.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import CHCommon

class CHBonjourManager: NSObject, NetServiceBrowserDelegate {
	
	fileprivate let serviceBrowser = NetServiceBrowser()
	
	
	fileprivate var unresolvedServices = [NetService]()
	var services = [NetService]()
	
	
	static let sharedManager = CHBonjourManager()
	
	override init() {
		super.init()
		
		self.startBrowser()
	}
	
	fileprivate func startBrowser() {
		self.serviceBrowser.delegate = self
		
		self.serviceBrowser.searchForServices(ofType: "_http._tcp", inDomain: "")
	}
	
	func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
		service.delegate = self
		service.resolve(withTimeout: 3000)
	}
	
	func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
		var indexToDelete = 0
		
		for i in 0 ..< self.services.count {
			if self.services[i] == service {
				indexToDelete = i
				break
			}
		}
		
		self.services.remove(at: indexToDelete)
		
		NotificationCenter.default.post(name: Notification.Name(rawValue: CHNotifBonjourServiceRemoved()), object: service)
	}
}

extension CHBonjourManager: NetServiceDelegate {
	func netServiceWillResolve(_ sender: NetService) {
		self.services.append(sender)
		
		NotificationCenter.default.post(name: Notification.Name(rawValue: CHNotifBonjourServiceAdded()), object: sender)
	}
}
