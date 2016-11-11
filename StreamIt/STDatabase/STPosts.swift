//
//  STPosts.swift
//  StreamIt
//
//  Created by Ryan DiCintio on 2016-11-10.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import Realm

public class STPost: RLMObject {
    dynamic var post_type = ""
    dynamic var body = ""
    dynamic var image_url = ""
    dynamic var image_data = ""
    dynamic var video_url = ""
    dynamic var mod_status = ""
    dynamic var submission_time = ""
}
