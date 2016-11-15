//
//  ViewController.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-10-03.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

class CHInitialViewController: UIViewController {

	var joinCard: CHGenericCardView!
	var startCard: CHGenericCardView!
	
	var controller: CHInitialController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.controller = CHInitialController(delegate: self)
		
		UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
		
		self.view.backgroundColor = UIColor.darkBackgroundColor()
		self.edgesForExtendedLayout = UIRectEdge.None
		
		self.addLogoToNav()
		
		self.startCard = CHStartSessionCardView.buildFromNib("Start a Chipmunk Session", controller: self.controller)
		let startCardContainer = CHGradientContainerView(view: self.startCard)
		self.view.addSubview(startCardContainer)
		self.view.addConstraints(NSLayoutConstraint.constraintsPinningViewInsideSuperView(startCardContainer, topSpace: 15, sideSpace: 10))
		
		self.joinCard = CHTableCardView(title: "Join a Chipmunk Session", tableDelegate: self.controller)
		let joinCardContainer = CHGradientContainerView(view: self.joinCard)
		self.view.addSubview(joinCardContainer)
		self.view.addConstraints(NSLayoutConstraint.constraintsPinningViewInsideSuperViewBottom(joinCardContainer, space: 10))
		
		
		self.view.addConstraints(self.generateCardHeightConstraints(joinCardContainer, start: startCardContainer))
		
		self.view.layoutSubviews()
	}
	
	func pushJoinSessionViewController(viewController: CHJoinSessionViewController) {
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	func pushStartSessionViewController(viewController: CHStartSessionViewController) {
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	func generateCardHeightConstraints(join: CHGradientContainerView, start: CHGradientContainerView) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints.append(NSLayoutConstraint(item: join, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: -20))
		constraints.append(NSLayoutConstraint(item: start, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: -20))
		
		return constraints
	}
	
	func addLogoToNav() {
		let logo = UIImageView(frame: CGRect(x: self.view.frame.width/2 - 25, y: -5, width: 50, height: 50))
		logo.image = UIImage(named: "chipmunk-white")
		
		self.navigationController?.navigationBar.addSubview(logo)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

