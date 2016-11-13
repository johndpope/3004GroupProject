//
//  ViewController.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-10-03.
//  Copyright © 2016 3004Group. All rights reserved.
//

import UIKit

class STInitialViewController: UIViewController {

	var joinCard: STGenericCardView!
	var startCard: STGenericCardView!
	
	var controller: STInitialController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.controller = STInitialController(delegate: self)
		
		self.edgesForExtendedLayout = UIRectEdge.None
		self.title = "StreamIt"
		
		self.joinCard = STTableCardView(title: "Join a StreamIt Session", tableDelegate: self.controller)
		self.view.addSubview(self.joinCard)
		self.view.addConstraints(NSLayoutConstraint.constraintsPinningViewInsideSuperView(self.joinCard, topSpace: 20, sideSpace: 20))
		
		self.startCard = STStartSessionCardView(title: "Start a StreamIt Session", controller: self.controller)
		self.view.addSubview(self.startCard)
		self.view.addConstraints(NSLayoutConstraint.constraintsPinningViewInsideSuperViewBottom(self.startCard, space: 20))
		
		self.view.addConstraints(self.generateCardHeightConstraints(self.joinCard, start: self.startCard))
		
		self.view.layoutSubviews()
	}
	
	func pushJoinSessionViewController(viewController: STJoinSessionViewController) {
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	func generateCardHeightConstraints(join: STGenericCardView, start: STGenericCardView) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		
		constraints.append(NSLayoutConstraint(item: join, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: -30))
		constraints.append(NSLayoutConstraint(item: start, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: -30))
		
		return constraints
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

