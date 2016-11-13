//
//  STBonjourManager.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import CHCommon

class CHBonjourManager: NSObject, NSNetServiceBrowserDelegate {
	
	private let serviceBrowser = NSNetServiceBrowser()
	
	
	private var unresolvedServices = [NSNetService]()
	var services = [NSNetService]()
	
	
	static let sharedManager = CHBonjourManager()
	
	override init() {
		super.init()
		
		self.startBrowser()
	}
	
	private func startBrowser() {
		self.serviceBrowser.delegate = self
		
		self.serviceBrowser.searchForServicesOfType("_http._tcp", inDomain: "")
	}
	
	func netServiceBrowser(browser: NSNetServiceBrowser, didFindService service: NSNetService, moreComing: Bool) {
		service.delegate = self
		service.resolveWithTimeout(3000)
	}
	
	func netServiceBrowser(browser: NSNetServiceBrowser, didRemoveService service: NSNetService, moreComing: Bool) {
		var indexToDelete = 0
		
		for i in 0 ..< self.services.count {
			if self.services[i] == service {
				indexToDelete = i
				break
			}
		}
		
		self.services.removeAtIndex(indexToDelete)
		
		NSNotificationCenter.defaultCenter().postNotificationName(CHNotifBonjourServiceRemoved(), object: service)
	}
}

extension CHBonjourManager: NSNetServiceDelegate {
	func netServiceWillResolve(sender: NSNetService) {
		self.services.append(sender)
		
		NSNotificationCenter.defaultCenter().postNotificationName(CHNotifBonjourServiceAdded(), object: sender)
	}
}
