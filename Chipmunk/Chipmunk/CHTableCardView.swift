//
//  STTableCardView.swift
//  StreamIt
//
//  Created by Connor MacBook on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit
import CHCommon

class CHTableCardView: CHGenericCardView {
	
	var tableView: UITableView!
	var tableDelegate: CHInitialController!
	
	init(title: String, tableDelegate: CHInitialController) {
		super.init(title: title)
		
		self.subscribe()
		
		self.tableDelegate = tableDelegate
		self.tableView = self.generateTableView()
		
		self.addSubview(self.tableView)
		self.addConstraints(NSLayoutConstraint.constraintsPinningViewInsideSuperView(self.tableView, topSpace: 40))
		
		self.layoutSubviews()
	}
	
	func subscribe() {
		NotificationCenter.default.addObserver(self, selector: #selector(CHTableCardView.reloadTableData(_:)), name: NSNotification.Name(rawValue: CHNotifBonjourServiceAdded()),  object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(CHTableCardView.reloadTableData(_:)), name: NSNotification.Name(rawValue: CHNotifBonjourServiceRemoved()) , object: nil)
	}
	
	func reloadTableData(_ sender: Notification) {
		self.tableView.reloadData()
	}
	
	func generateTableView() -> UITableView {
		let table = UITableView(frame: CGRect.zero)
		table.translatesAutoresizingMaskIntoConstraints = false
		table.delegate = self.tableDelegate
		table.dataSource = self.tableDelegate
		
		table.backgroundColor = UIColor.darkBackgroundColor()
		table.separatorColor = UIColor.lightForegroundColor()
		
		return table
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
