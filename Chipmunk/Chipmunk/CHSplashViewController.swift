//
//  CHSplashViewController.swift
//  Chipmunk
//
//  Created by Connor MacBook on 2016-11-17.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

class CHSPlashViewController: UIViewController {
	@IBOutlet weak var topConstraint: NSLayoutConstraint!
	@IBOutlet weak var leadingConstraint: NSLayoutConstraint!
	@IBOutlet weak var trailingConstraint: NSLayoutConstraint!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		UIView.animateWithDuration(3000, animations: {() in
			self.topConstraint.constant = 5
			self.bottomConstraint.constant = 5
			self.leadingConstraint.constant = 5
			self.trailingConstraint.constant = 5
		})

		
		let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
		
		dispatch_after(delayTime, dispatch_get_main_queue(), {() in
			let navController = UINavigationController(rootViewController: CHInitialViewController())
			navController.navigationBar.barTintColor = UIColor.darkBackgroundColor()
			navController.navigationBar.tintColor = UIColor.appTintColor()
			navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
			
			self.presentViewController(navController, animated: true, completion: nil)
		})
	}
}
