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

public class CHSession: RLMObject {
    var session_name: NSString?
    var session_pass: NSString?
    var num_items_onscreen: Int8 = 0
    var chromecast_id: CHChromecastConfig? //STChromecastConfig
    var auto_mod: Bool?
    
    override init() {
        super.init()
    }
    
    
    
}

public class CHChromecastConfig : RLMObject {
    
    override init() {
        super.init()
    }
}


