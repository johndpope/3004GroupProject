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
	
	var services: [NetService] {
		return self.bonjourManager.services
	}
	
	init(delegate: CHInitialViewController) {
		super.init()
		
		self.delegate = delegate
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.services.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "")
		
		cell.backgroundColor = UIColor.darkBackgroundColor()
		
		cell.textLabel?.text = self.services[indexPath.row].name
		cell.textLabel?.textColor = UIColor.white
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let title = self.services[indexPath.row].name
		
		let sessionConfig = CHSessionConfig(title: title, password: "", service: self.services[indexPath.row])
		let joinSessionViewController = CHPostContentViewController(config: sessionConfig)
		
		if let del = self.delegate {
			del.pushJoinSessionViewController(joinSessionViewController)
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

// MARK - New Session Controller
extension CHInitialController {
	func startSessionPressed(_ title: String, password: String) {
		if let del = self.delegate {
			let sessionConfig = CHSessionConfig(title: title, password: password, service: nil)
			del.pushStartSessionViewController(CHStartSessionViewController(config: sessionConfig))
		}
	}
}
