//
//  CHStartSessionViewController.swift
//  Chipmunk
//
//  Created by Connor MacBook on 2016-11-14.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit
import CHCommon
import GoogleCast
import CHHTTPServer

class CHStartSessionViewController: UIViewController {
	
	var config: CHSessionConfig!
	
	@IBOutlet weak var passwordLabel: UILabel!
	
	@IBOutlet weak var stepper: UIStepper!
	@IBOutlet weak var numCellsLabel: UILabel!
	@IBOutlet weak var card: CHGenericCardView!
	@IBOutlet weak var castButton: UIButton!
	
	
	init(config: CHSessionConfig) {
		super.init(nibName: "CHStartSessionView", bundle: nil)
		
		self.title = "Configure Session"
		
		self.config = config
		self.config.numCells = 4
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CHStartSessionViewController.startWebServer), name: CHNotifCastSessionStarted(), object: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.edgesForExtendedLayout = UIRectEdge.None
		
		stepper.maximumValue = 12
		stepper.minimumValue = 4
		stepper.stepValue = 2
		
		self.numCellsLabel.text = "Items on screen: \(Int(self.stepper.value))"
		self.passwordLabel.text = self.config.password! != "" ? "Password: \(self.config.password!)" : "No Password"
		
		self.card.titleLabel.text = "Session: \(self.config.title)"
		
		self.castButton.backgroundColor = UIColor.appTintColor()
		self.castButton.layer.cornerRadius = 4
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBAction func castPressed() {
		CHCastManager.sharedManager.config = self.config
		GCKCastContext.sharedInstance().presentCastDialog()
	}
	
	@IBAction func stepperValueChanged(sender: UIStepper) {
		self.config!.numCells = Int(sender.value)
		self.numCellsLabel.text = "Items on screen: \(Int(sender.value))"
	}
	
	func startWebServer() {
		CHWebServer.defaultServer.start()
	}
}
