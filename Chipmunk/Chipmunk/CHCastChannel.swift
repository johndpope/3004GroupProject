//
//  CHCastChannel.swift
//  Chipmunk
//
//  Created by Connor MacBook on 2016-11-13.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import GoogleCast

// [START custom-channel-1]
// This custom channel class extends GCKCastChannel.
open class CHCastChannel : GCKCastChannel {
	
	override open func didReceiveTextMessage(_ message: String) {
		print("Received message: \(message)")
	}
}
