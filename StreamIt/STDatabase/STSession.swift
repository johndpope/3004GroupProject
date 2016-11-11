//
//  STSession.swift
//  StreamIt
//
//  Created by Ryan DiCintio on 2016-11-10.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import Realm

public class STSession: RLMObject {
    dynamic var session_name = ""
    dynamic var session_pass = ""
    dynamic var num_items_onscreen = 0
    dynamic var chromecast_id = "" //STChromecastConfig
    dynamic var auto_mod = true
}

public class STChromcastConfig : RLMObject {
    
}



