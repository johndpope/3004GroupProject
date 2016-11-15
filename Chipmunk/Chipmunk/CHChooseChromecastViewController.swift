//
//  CHStartSessionViewController.swift
//  Chipmunk
//
//  Created by Connor MacBook on 2016-11-13.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit
import GoogleCast
import CHCommon
import CHHTTPServer

class CHChooseChromecastViewController: UIViewController {
	var config: CHSessionConfig!
	
	var googleCastButton: UIButton!
	var messageButton: UIButton!
	var textButton: UIButton!
	
	let castManager = CHCastManager.sharedManager
	
	let images = ["http://i.imgur.com/Ac3jwuN.jpg", "https://thumbs.gfycat.com/PepperyVillainousBedlingtonterrier-size_restricted.gif", "https://thumbs.gfycat.com/OrangeInexperiencedDachshund-size_restricted.gif", "https://i.reddituploads.com/f82a71d325984de8a523ba69102edbdc?fit=max&h=1536&w=1536&s=5ecc78fe352a22ee9ac3a9d7e254f94d", "http://i.imgur.com/coes6Pd.jpg"]
	var imageIndex = 0
	
	init(config: CHSessionConfig) {
		super.init(nibName: nil, bundle: nil)
		self.title = "Start Session"
		
		self.view.backgroundColor = UIColor.whiteColor()
		
		self.config = config
		self.castManager.config = self.config
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CHChooseChromecastViewController.startServer), name: CHNotifCastSessionStarted(), object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CHChooseChromecastViewController.stopServer), name: CHNotifCastSessionEnded(), object: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.edgesForExtendedLayout = UIRectEdge.None
		
		self.googleCastButton = UIButton(frame: CGRectZero)
		self.googleCastButton.translatesAutoresizingMaskIntoConstraints = false
		
		self.messageButton = UIButton(frame: CGRectZero)
		self.messageButton.translatesAutoresizingMaskIntoConstraints = false
		
		self.textButton = UIButton(frame: CGRectZero)
		self.textButton.translatesAutoresizingMaskIntoConstraints = false
		
		self.setupCastButton()
		self.setupMessageButton()
		self.setupTextButton()
	}
	
	func setupCastButton() {
		
		self.googleCastButton.setTitle("Cast", forState: .Normal)
		self.googleCastButton.addTarget(self, action: #selector(CHChooseChromecastViewController.showCastDialog), forControlEvents: .TouchUpInside)
		
		self.googleCastButton!.setTitleColor(UIColor.blueColor(), forState: .Normal)
		
		self.view.addSubview(self.googleCastButton)
		self.view.addConstraints(NSLayoutConstraint.constraintsPinningToTopLeftOfSuperview(self.googleCastButton, padding: 40))
		self.view.addConstraint(NSLayoutConstraint(item: self.googleCastButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 0, constant: 40))
		self.view.addConstraint(NSLayoutConstraint(item: self.googleCastButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 0, constant: 60))
		
		self.view.layoutSubviews()
	}
	
	func setupMessageButton() {
		self.messageButton.setTitle("Send Message", forState: .Normal)
		self.messageButton.addTarget(self, action: #selector(CHChooseChromecastViewController.sendMessage), forControlEvents: .TouchUpInside)
		
		self.messageButton!.setTitleColor(UIColor.blueColor(), forState: .Normal)
		
		self.view.addSubview(self.messageButton)
		
		self.view.addConstraint(NSLayoutConstraint(item: self.messageButton, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 40))
		self.view.addConstraint(NSLayoutConstraint(item: self.messageButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 90))
		self.view.addConstraint(NSLayoutConstraint(item: self.messageButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 0, constant: 40))
		self.view.addConstraint(NSLayoutConstraint(item: self.messageButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 0, constant: 120))
		
		self.view.layoutSubviews()
	}
	
	func setupTextButton() {
		self.textButton.setTitle("Send Text", forState: .Normal)
		self.textButton.addTarget(self, action: #selector(CHChooseChromecastViewController.sendText), forControlEvents: .TouchUpInside)
		
		self.textButton!.setTitleColor(UIColor.blueColor(), forState: .Normal)
		
		self.view.addSubview(self.textButton)
		
		self.view.addConstraint(NSLayoutConstraint(item: self.textButton, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 40))
		self.view.addConstraint(NSLayoutConstraint(item: self.textButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 180))
		self.view.addConstraint(NSLayoutConstraint(item: self.textButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 0, constant: 40))
		self.view.addConstraint(NSLayoutConstraint(item: self.textButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 0, constant: 120))
		
		self.view.layoutSubviews()
	}
	
	func showCastDialog() {
		GCKCastContext.sharedInstance().presentCastDialog()
	}
	
	func startServer() {
		CHWebServer.defaultServer.start()
	}
	
	func stopServer() {
		//CHWebServer.defaultServer.stop()
	}
	
	func sendMessage() {
		self.castManager.channel.sendTextMessage("{\"content\": {\"type\": \"image\", \"src\": \"\(self.images[self.imageIndex])\"}}", error: nil)
		
		if(self.imageIndex == 4) {
			self.imageIndex = 0
		}
		else {
			self.imageIndex += 1
		}
	}
	
	func sendText() {
		self.castManager.channel.sendTextMessage("{\"content\": {\"type\": \"text\", \"src\": \"Healthy Cock Bro\"}}", error: nil)
	}
}
