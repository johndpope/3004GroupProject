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
		
		self.title = "Moderation"
		
		self.sessionConfig = config
		self.controller = CHModerationController()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CHModerationViewController.closeModeration), name: CHNotifWebServerStopped(), object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CHModerationViewController.postsChanged), name: CHNotifPostsToModerateChanged(), object: nil)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self.controller
		self.tableView.dataSource = self.controller
		
		self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CHTableCell")
		self.tableView.backgroundColor = UIColor.darkBackgroundColor()
		
		self.controller.loadPostsToModerate()
		self.tableView.reloadData()
	}
	
	@IBAction func acceptPressed(sender: AnyObject) {
		self.controller.acceptNextPost()
	}
	
	@IBAction func rejectPressed(sender: AnyObject) {
		self.controller.rejectNextPost()
	}
	
	func postsChanged() {
		self.controller.loadPostsToModerate()
		self.tableView.reloadData()
	}
	
	func closeModeration() {
		self.navigationController?.popViewControllerAnimated(true)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
