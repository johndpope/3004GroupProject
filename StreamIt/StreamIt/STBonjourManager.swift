//
//  STBonjourManager.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import STCommon

class STBonjourManager: NSObject, NSNetServiceBrowserDelegate {
	
	private let serviceBrowser = NSNetServiceBrowser()
	
	var services = [NSNetService]()
	
	
	static let sharedManager = STBonjourManager()
	
	override init() {
		super.init()
		
		self.startBrowser()
	}
	
	private func startBrowser() {
		self.serviceBrowser.delegate = self
		
		self.serviceBrowser.searchForServicesOfType(STConstBonjourName(), inDomain: "")
	}
	
	func netServiceBrowser(browser: NSNetServiceBrowser, didFindService service: NSNetService, moreComing: Bool) {
		self.services.append(service)
		
		NSNotificationCenter.defaultCenter().postNotificationName(STNotifBonjourServiceAdded(), object: service)
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
		
		NSNotificationCenter.defaultCenter().postNotificationName(STNotifBonjourServiceRemoved(), object: service)
	}
}
