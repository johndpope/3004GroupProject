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
import SwiftyJSON

class CHModerationController: NSObject {
	var posts = [CHPost]()
	
	func loadPostsToModerate() {
		self.posts.removeAll()
		
		let postArray = CHDatabaseManager.defaultManager.getAllPostsToModerate()
		
		for post in postArray {
			self.posts.append(post)
		}
	}
	
	func acceptNextPost() {
		let postToAccept = self.posts.last!
		
		let postType = postToAccept.post_type!
		
		let dict: [String: AnyObject] = ["content": ["src": postToAccept.body as! String, "type": postType]]
		
		let castJSON = JSON(dict)
		let castManager = CHCastManager.sharedManager
		
		if (castManager.isConnected()) {
			castManager.channel.sendTextMessage(castJSON.rawString()!, error: nil)
		}
		
		////
		//// THIS SHOULD ACTUALLY SET MOD_STATUS TO TRUE, REALM IS FUCKED AND THIS IS A WORKAROUND
		////
		CHDatabaseManager.defaultManager.setPostAccepted(postToAccept.uuid!)
	}
	
	func rejectNextPost() {
		let postToReject = self.posts.last!
		
		CHDatabaseManager.defaultManager.deletePost(postToReject.uuid!)
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
		let cell = tableView.dequeueReusableCellWithIdentifier("CHTableCell")!
		let post = self.posts[indexPath.row]
		
		cell.backgroundColor = UIColor.darkBackgroundColor()
		cell.textLabel?.textColor = UIColor.whiteColor()
		
		cell.textLabel?.text = post.body as? String
		
		return cell
	}
}
