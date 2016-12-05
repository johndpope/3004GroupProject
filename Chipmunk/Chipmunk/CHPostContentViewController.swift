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

class CHPostContentViewController: UIViewController {
	
	var config: CHSessionConfig!
	
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var sendButton: UIButton!
	@IBOutlet weak var sendImageButton: UIButton!
	
	init(config: CHSessionConfig) {
		super.init(nibName: "CHPostContentView", bundle: nil)
		
		self.config = config
		
		let titleComponents = self.config.title.componentsSeparatedByString(".")
		self.title = titleComponents.last
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.edgesForExtendedLayout = UIRectEdge.None
		
		self.textView.backgroundColor = UIColor.darkBackgroundColor()
		self.textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		
		self.sendButton.backgroundColor = UIColor.appTintColor()
		self.sendButton.layer.cornerRadius = 4
		self.sendImageButton.backgroundColor = UIColor.appTintColor()
		self.sendImageButton.layer.cornerRadius = 4
		
		self.textView.becomeFirstResponder()
	}
	
	@IBAction func sendPressed() {
		let APIClient = CHAPIClient(service: self.config.service!)
		
		if (self.textView.text != "") {
			let postJSON = JSON(["post_type": "text", "body": self.textView.text!])
			APIClient.sendPost(postJSON, completion: {(response: String) in
				print(response)
				
				self.textView.text = ""
			})
		}
	}
	
	@IBAction func sendImagePressed(sender: AnyObject) {
		let APIClient = CHAPIClient(service: self.config.service!)
		if (self.textView.text != "") {
			let postJSON = JSON(["post_type": "image", "body": self.textView.text!])
			APIClient.sendPost(postJSON, completion: {(response: String) in
				print(response)
			})
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
