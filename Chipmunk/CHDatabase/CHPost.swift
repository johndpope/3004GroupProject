//
//  STPosts.swift
//  StreamIt
//
//  Created by Ryan DiCintio on 2016-11-10.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import Realm
import CHCommon

open class CHPost: Object {
    open dynamic var uuid: String?
    open var post_type: CHPostType?
    open dynamic var body: NSString?
    open dynamic var image_url: NSString?
    open dynamic var image_data: Data?
    open dynamic var video_url: NSString?
    open var mod_status: Bool?
    open dynamic var submission_time: Date?
    open dynamic var mod_acceptance_time: Date? //time of acceptance from host
    
    override open static func primaryKey() -> String? {
        return "uuid"
    }
    
}
