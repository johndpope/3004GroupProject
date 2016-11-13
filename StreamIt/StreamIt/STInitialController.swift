//
//  STInitialController.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit
import STHTTPServer
import STCommon

class STInitialController: NSObject, UITableViewDataSource, UITableViewDelegate {
	
	weak var delegate: STInitialViewController?
	
	var bonjourManager = STBonjourManager.sharedManager
	
	var server = STWebServer() // TODO: Singleton this bitch
	
	var services: [NSNetService] {
		return self.bonjourManager.services
	}
	
	init(delegate: STInitialViewController) {
		super.init()
		
		self.delegate = delegate
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.services.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
		
		cell.textLabel?.text = self.services[indexPath.row].name
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let title = self.services[indexPath.row].name
		
		let sessionConfig = STSessionConfig(title: title, service: self.services[indexPath.row])
		let joinSessionViewController = STJoinSessionViewController(config: sessionConfig)
		
		if let del = self.delegate {
			del.pushJoinSessionViewController(joinSessionViewController)
		}
		
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
}

// MARK - New Session Controller
extension STInitialController {
	func startServerPressed() {
		self.server.start()
	}
}
