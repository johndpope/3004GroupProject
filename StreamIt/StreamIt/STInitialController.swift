//
//  STInitialController.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

class STInitialController: NSObject, UITableViewDataSource, UITableViewDelegate {
	
	weak var delegate: STInitialViewController?
	
	let titles = ["kyle", "jagger", "ryan"]
	
	init(delegate: STInitialViewController) {
		super.init()
		
		self.delegate = delegate
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
		
		cell.textLabel?.text = self.titles[indexPath.row]
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let title = self.titles[indexPath.row]
		
		let sessionConfig = STSessionConfig(title: title, service: NSNetService(domain: "aasdf", type: "asdf", name: title))
		let joinSessionViewController = STJoinSessionViewController(config: sessionConfig)
		
		if let del = self.delegate {
			del.pushJoinSessionViewController(joinSessionViewController)
		}
		
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
}
