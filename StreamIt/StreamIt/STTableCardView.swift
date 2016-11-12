//
//  STTableCardView.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

class STTableCardView: STGenericCardView {
	
	var tableView: UITableView!
	var tableDelegate: STInitialController!
	
	init(title: String, tableDelegate: STInitialController) {
		super.init(title: title)
		
		self.tableDelegate = tableDelegate
		self.tableView = self.generateTableView()
		
		self.addSubview(self.tableView)
		self.addConstraints(NSLayoutConstraint.constraintsPinningViewInsideSuperView(self.tableView, topSpace: 40))
		
		self.layoutSubviews()
	}
	
	func generateTableView() -> UITableView {
		let table = UITableView(frame: CGRectZero)
		table.translatesAutoresizingMaskIntoConstraints = false
		table.delegate = self.tableDelegate
		table.dataSource = self.tableDelegate
		
		return table
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
