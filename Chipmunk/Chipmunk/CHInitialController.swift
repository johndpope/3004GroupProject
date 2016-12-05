//
//  STInitialController.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit
import CHHTTPServer
import CHCommon

class CHInitialController: NSObject, UITableViewDataSource, UITableViewDelegate {
	
	weak var delegate: CHInitialViewController?
	
	var bonjourManager = CHBonjourManager.sharedManager
	
	var server = CHWebServer() // TODO: Singleton this bitch
	
	var services: [NSNetService] {
		return self.bonjourManager.services
	}
	
	init(delegate: CHInitialViewController) {
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
		
		cell.backgroundColor = UIColor.darkBackgroundColor()
		
		cell.textLabel?.text = self.services[indexPath.row].name
		cell.textLabel?.textColor = UIColor.whiteColor()
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let title = self.services[indexPath.row].name
		
		let sessionConfig = CHSessionConfig(title: title, password: "", service: self.services[indexPath.row])
		let joinSessionViewController = CHPostContentViewController(config: sessionConfig)
		
		if let del = self.delegate {
			del.pushJoinSessionViewController(joinSessionViewController)
		}
		
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
}

// MARK - New Session Controller
extension CHInitialController {
	func startSessionPressed(title: String, password: String) {
		if let del = self.delegate {
			let sessionConfig = CHSessionConfig(title: title, password: password, service: nil)
			del.pushStartSessionViewController(CHStartSessionViewController(config: sessionConfig))
		}
	}
}
