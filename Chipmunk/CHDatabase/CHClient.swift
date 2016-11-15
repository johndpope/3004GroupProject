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

public class CHClient: Object {
    public dynamic var username : String?
    public dynamic var uuid : String?
    public dynamic var session_id : String?
    public dynamic var join_time : NSDate?
    
    override public static func primaryKey() -> String? {
        return "uuid"
    }
}

