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

public class CHPost: RLMObject {
    public var uuid: String?
    public var post_type: CHPostType?
    public var body: NSString?
    public var image_url: NSURL?
    public var image_data: NSData?
    public var video_url: NSURL?
    public var mod_status: Bool?
    public var submission_time: NSDate?
    public var mod_acceptance_time: NSDate? //time of acceptance from host
    
    
    public override init() {
        super.init()
    }
    
}
