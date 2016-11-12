//
//  STPosts.swift
//  StreamIt
//
//  Created by Ryan DiCintio on 2016-11-10.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import Realm
import STCommon

public class STPost: RLMObject {
    var uuid: String?
    var post_type: STPostType?
    var body: NSString?
    var image_url: NSURL?
    var image_data: NSData?
    var video_url: NSURL?
    var mod_status: Bool?
    var submission_time: NSDate?
    var mod_acceptance_time: NSDate? //time of acceptance from host
    
    
    override init() {
        super.init()
    }
    
 
    //function to add or update submission to realm
    func addOrUpdateSubmission(newSubmission: STPost) {
        if (newSubmission.uuid == nil) {
            newSubmission.uuid = NSUUID().UUIDString
        }
        RLMRealm.defaultRealm().addOrUpdateObject(newSubmission)
    }
    
    //function to delete submission
    func deleteSubmission(submission: STPost) {
        if (submission.uuid != nil) {
            RLMRealm.defaultRealm().deleteObject(submission)
        } else {
            print("submission does not exist")
        }
    }
    
    
    //function returning entire collection
    func collection() -> RLMResults {
        return STPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: nil)
    }

    
    
    //function returning submissions marked as accepted
    func getModSubmissions() -> RLMResults {
        return STPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = true"))
    }
    
    
    //function returning submissions ordered by acceptance time
    func getSubmissionsAcceptanceTime() -> RLMResults {
        return STPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = true")).sortedResultsUsingProperty("mod_acceptance_time", ascending: false)
    }
    
    
    //function returning submissions marked as NOT accepted (sorted in order of most recent submission first)
    func getUnacceptedSubmissions() -> RLMResults {
        return STPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = false")).sortedResultsUsingProperty("submission_time", ascending: false)
    }
    
    
    //function returning most submissions ordered by most recent unacceptance first
    func getSubmissionsUnacceptanceTime() -> RLMResults {
        return STPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = false")).sortedResultsUsingProperty("mod_acceptance_time", ascending: false)
    }
    
    
    
    
}
