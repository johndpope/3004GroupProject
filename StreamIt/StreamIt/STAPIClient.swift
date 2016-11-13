//
//  STAPIClient.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-12.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation

class STAPIClient: NSObject {
	var service: NSNetService!
	
	init(service: NSNetService) {
		super.init()
		
		self.service = service
	}
	
	func getRootURLString(completion: (String) -> Void) {
		self.get(self.baseURL(), completionOnMain: completion)
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
}
