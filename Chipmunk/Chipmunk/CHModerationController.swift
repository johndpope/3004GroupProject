//
//  CHModerationController.swift
//  Chipmunk
//
//  Created by Connor MacBook on 2016-12-04.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit
import CHCommon
import CHDatabase

class CHModerationController: NSObject {
	var posts = [CHPost]()
	
	func loadPostsToModerate() {
		
	}
}

extension CHModerationController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.posts.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		<#code#>
	}
}
