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
    public var session_name: NSString?
    public var session_pass: NSString?
    public var num_items_onscreen: Int8 = 0
    public var chromecast_id: CHChromecastConfig? //STChromecastConfig
    public var auto_mod: Bool?
    
    public override init() {
        super.init()
    }
}

public class CHChromecastConfig : RLMObject {
    
    override init() {
        super.init()
    }
}



