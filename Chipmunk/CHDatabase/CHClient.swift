//
//  STClients.swift
//  StreamIt
//
//  Created by Ryan DiCintio on 2016-11-10.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import Realm
import CHCommon

public class CHClient: RLMObject {
    public var username : String?
    public var uuid : String?
    public var session_id : String?
    public var join_time : NSDate?
    
    
    public override init() {
        super.init()
    }
    
}

