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
	static func flexibleImageView(_ named: String, contentMode: UIViewContentMode) -> UIImageView {
		let image = UIImageView(image: UIImage(named: named))
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = contentMode
		
		return image
	}
	
	func setImageWithURLRequest(_ urlRequest: URLRequest, placeholderImage: UIImage?, success: ((UIImage) -> Void)?, failure: ((NSError) -> Void)?) {
		let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data: Data?, response: URLResponse?, error: NSError?) in
			if let err = error {
				print("Failed to download image error: \(err.localizedDescription)")
				failure?(err)
			}
			if let imageData = data {
				let image = UIImage(data: imageData)!
				
				success?(image)
			}
		} as! (Data?, URLResponse?, Error?) -> Void)
		
		downloadTask.resume()
		
		if let placeholder = placeholderImage {
			self.image = placeholder
		}
	}
}
