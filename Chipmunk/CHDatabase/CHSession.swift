//
//  STSession.swift
//  StreamIt
//
//  Created by Ryan DiCintio on 2016-11-10.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import Realm
import CHCommon

open class CHSession: RLMObject {
    open var session_name: NSString?
    open var session_pass: NSString?
    open var num_items_onscreen: Int8 = 0
    open var chromecast_id: CHChromecastConfig? //STChromecastConfig
    open var auto_mod: Bool?
    
    public override init() {
        super.init()
    }
}

open class CHChromecastConfig : RLMObject {
    
    override init() {
        super.init()
    }
}



