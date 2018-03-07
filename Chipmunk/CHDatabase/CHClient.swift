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

open class CHClient: Object {
    open dynamic var username : String?
    open dynamic var uuid : String?
    open dynamic var session_id : String?
    open dynamic var join_time : Date?
    
    override open static func primaryKey() -> String? {
        return "uuid"
    }
}

