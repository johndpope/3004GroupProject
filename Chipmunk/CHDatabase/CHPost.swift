//
//  STPosts.swift
//  StreamIt
//
//  Created by Ryan DiCintio on 2016-11-10.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import RealmSwift
import CHCommon

public class CHPost: Object {
    public dynamic var uuid: String?
    public dynamic var post_type: String? // This needs to go back to CHPostType when we figure out Realm's shit
    public dynamic var body: NSString?
    public dynamic var image_url: NSString?
    public dynamic var image_data: NSData?
    public dynamic var video_url: NSString?
    public dynamic var mod_status: Bool = false
    public dynamic var submission_time: NSDate?
    public dynamic var mod_acceptance_time: NSDate? //time of acceptance from host
    
    override public static func primaryKey() -> String? {
        return "uuid"
    }
    
}
