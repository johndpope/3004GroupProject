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
	var service: NetService!
	
	init(service: NetService) {
		super.init()
		
		self.service = service
	}
	
	func getRootURLString(_ completion: @escaping (String) -> Void) {
		self.get(self.baseURL(), completionOnMain: completion)
	}
	
    func sendPost(_ body: JSON, completion: @escaping (String) -> Void) {
		let postUrl = self.baseURL().appendingPathComponent("post")
        self.post(postUrl, body: body, completionOnMain: completion)
	}
	
	func baseURL() -> URL {
		var properHostname = self.service.hostName!
		properHostname.remove(at: properHostname.characters.index(before: properHostname.endIndex))
		
		return URL(string: "http://\(properHostname):\(self.service.port)")!
	}
	
	func get(_ url: URL, completionOnMain: @escaping (String) -> Void) {
		let session = URLSession.shared
		let request = URLRequest(url: url)
		
		let task = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: NSError?) in
			if let err = error {
				DispatchQueue.main.async(execute: {() in
					completionOnMain(err.localizedDescription)
				})
			}
			else if let body = data {
				DispatchQueue.main.async(execute: {() in
					completionOnMain(NSString(data: body, encoding: String.Encoding.utf8.rawValue) as! String)
				})
			}
		} as! (Data?, URLResponse?, Error?) -> Void)
		
		task.resume()
	}
	
	func post(_ url: URL, body: JSON, completionOnMain: @escaping (String) -> Void) {
		let session = URLSession.shared
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		
		do {
			request.httpBody = try body.rawData()
		}
		catch {
			let err = error as NSError
			print(err.localizedDescription)
		}
		
        
        
		let task = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) in
			if let err = error {
				DispatchQueue.main.async(execute: {() in
					completionOnMain(err.localizedDescription)
				})
			}
			else if let body = data {
				DispatchQueue.main.async(execute: {() in
                    completionOnMain(NSString(data: body, encoding: String.Encoding.utf8.rawValue)! as String)
				})
			}
		})
		
		task.resume()
	}
}
