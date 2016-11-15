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

class CHStartSessionViewController: UIViewController {
	
	var config: CHSessionConfig?
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var passwordLabel: UILabel!
	
	@IBOutlet weak var stepper: UIStepper!
	@IBOutlet weak var numCellsLabel: UILabel!
	
	
	init(config: CHSessionConfig) {
		super.init(nibName: "CHStartSessionView", bundle: nil)
		
		self.title = "Configure Session"
		
		self.config = config
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		stepper.maximumValue = 12
		stepper.minimumValue = 4
		stepper.stepValue = 2
		
		self.numCellsLabel.text = "\(Int(self.stepper.value))"
		self.titleLabel.text = self.config!.title
		self.passwordLabel.text = self.config!.password != nil ? self.config!.password : "No Password"
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBAction func choosePressed() {
		self.navigationController?.pushViewController(CHChooseChromecastViewController(config: self.config!), animated: true)
	}
	
	@IBAction func stepperValueChanged(sender: UIStepper) {
		self.config!.numCells = Int(sender.value)
		self.numCellsLabel.text = "\(Int(sender.value))"
	}
}
