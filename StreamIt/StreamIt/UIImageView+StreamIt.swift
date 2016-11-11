//
//  UIImageView+StreamIt.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-10-31.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
	static func flexibleImageView(named: String, contentMode: UIViewContentMode) -> UIImageView {
		let image = UIImageView(image: UIImage(named: named))
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = contentMode
		
		return image
	}
	
	func setImageWithURLRequest(urlRequest: NSURLRequest, placeholderImage: UIImage?, success: ((UIImage) -> Void)?, failure: ((NSError) -> Void)?) {
		let downloadTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) in
			if let err = error {
				print("Failed to download image error: \(err.localizedDescription)")
				failure?(err)
			}
			if let imageData = data {
				let image = UIImage(data: imageData)!
				
				success?(image)
			}
		})
		
		downloadTask.resume()
		
		if let placeholder = placeholderImage {
			self.image = placeholder
		}
	}
}
