//
//  STAPIClient.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-12.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import SwiftyJSON

class CHAPIClient: NSObject {
	var service: NSNetService!
	
	init(service: NSNetService) {
		super.init()
		
		self.service = service
	}
	
	func getRootURLString(completion: (String) -> Void) {
		self.get(self.baseURL(), completionOnMain: completion)
	}
	
	func sendPost(body: JSON, completion: (String) -> Void) {
		let postUrl = self.baseURL().URLByAppendingPathComponent("post")
		self.post(postUrl!, body: body, completionOnMain: completion)
	}
	
	func baseURL() -> NSURL {
		var properHostname = self.service.hostName!
		properHostname.removeAtIndex(properHostname.endIndex.predecessor())
		
		return NSURL(string: "http://\(properHostname):\(self.service.port)")!
	}
	
	func get(url: NSURL, completionOnMain: (String) -> Void) {
		let session = NSURLSession.sharedSession()
		let request = NSURLRequest(URL: url)
		
		let task = session.dataTaskWithRequest(request, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) in
			if let err = error {
				dispatch_async(dispatch_get_main_queue(), {() in
					completionOnMain(err.localizedDescription)
				})
			}
			else if let body = data {
				dispatch_async(dispatch_get_main_queue(), {() in
					completionOnMain(NSString(data: body, encoding: NSUTF8StringEncoding) as! String)
				})
			}
		})
		
		task.resume()
	}
	
	func post(url: NSURL, body: JSON, completionOnMain: (String) -> Void) {
		let session = NSURLSession.sharedSession()
		let request = NSMutableURLRequest(URL: url)
		request.HTTPMethod = "POST"
		
		do {
			request.HTTPBody = try body.rawData()
		}
		catch {
			let err = error as NSError
			print(err.localizedDescription)
		}
		
		let task = session.dataTaskWithRequest(request, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) in
			if let err = error {
				dispatch_async(dispatch_get_main_queue(), {() in
					completionOnMain(err.localizedDescription)
				})
			}
			else if let body = data {
				dispatch_async(dispatch_get_main_queue(), {() in
					completionOnMain(NSString(data: body, encoding: NSUTF8StringEncoding) as! String)
				})
			}
		})
		
		task.resume()
	}
}
