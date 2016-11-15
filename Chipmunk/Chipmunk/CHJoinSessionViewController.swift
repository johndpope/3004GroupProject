//
//  STJoinSessionViewController.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit
import CHCommon
import SwiftyJSON

class CHJoinSessionViewController: UIViewController {
	
	var config: CHSessionConfig!
	
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var linkField: UITextField!
	
	init(config: CHSessionConfig) {
		super.init(nibName: "CHJoinSessionView", bundle: nil)
		
		self.config = config
		
		self.title = self.config.title
	}
	
	@IBAction func sendPressed() {
		let APIClient = CHAPIClient(service: self.config.service!)
		
		if (self.textField.text != "") {
			let postJSON = JSON(["post_type": "text", "body": self.textField.text!])
			APIClient.sendPost(postJSON, completion: {(response: String) in
				print(response)
			})
		}
		else if (self.linkField.text != "") {
			let postJSON = JSON(["post_type": "image", "body": self.linkField.text!])
			APIClient.sendPost(postJSON, completion: {(response: String) in
				print(response)
			})
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
