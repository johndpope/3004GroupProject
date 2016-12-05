//
//  CHModerationViewController.swift
//  Chipmunk
//
//  Created by Connor MacBook on 2016-12-04.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit
import CHCommon

class CHModerationViewController: UIViewController {
	
	var sessionConfig: CHSessionConfig!
	var controller: CHModerationController!
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var acceptButton: UIButton!
	@IBOutlet weak var rejectButton: UIButton!
	
	
	init(config: CHSessionConfig) {
		super.init(nibName: "CHModerationView", bundle: nil)
		
		self.sessionConfig = config
		self.controller = CHModerationController()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self.controller
		self.tableView.dataSource = self.controller
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
