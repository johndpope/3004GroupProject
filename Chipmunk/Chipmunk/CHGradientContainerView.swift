//
//  CHCardContainerView.swift
//  Chipmunk
//
//  Created by Connor MacBook on 2016-11-15.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import UIKit

class CHGradientContainerView: UIView {
	
	var gradientLayer: CAGradientLayer!
	
	var faded: Bool = false
	
	init(view: UIView) {
		super.init(frame: CGRect.zero)
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.setup()
		
		self.addSubview(view)
		self.addConstraints(NSLayoutConstraint.constraintsFillingSuperViewWithView(view, padding: 1.5))
		self.layoutSubviews()
	}
	
	convenience init(faded view: UIView) {
		self.init(view: view)
		self.faded = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setup()
	}
	
	func setup() {
		self.addGradient()
		
		self.layer.cornerRadius = 4
		self.clipsToBounds = true
	}
	
	func addGradient() {
		if let lay = self.gradientLayer {
			lay.removeFromSuperlayer()
		}
		
		self.gradientLayer = CAGradientLayer()
		self.gradientLayer!.colors = self.faded ? [UIColor.gradient1ColorFaded().cgColor, UIColor.gradient2ColorFaded().cgColor] : [UIColor.gradient1Color().cgColor, UIColor.gradient2Color().cgColor]
		self.gradientLayer!.locations = [0.2, 0.8]
		// This goddamn view is never layed out properly when the layer is added so we have to force the frame size. Dumb.
		self.gradientLayer!.frame = CGRect(x: -20, y: -20, width: self.bounds.width + 40, height: self.bounds.height + 40)
		
		self.layer.insertSublayer(self.gradientLayer, at: 0)
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		self.addGradient()
	}
}
