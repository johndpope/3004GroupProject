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
    var uuid: String?
    var post_type: CHPostType?
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
    func addOrUpdatePost(newSubmission: CHPost) {
        if (newSubmission.uuid == nil) {
            newSubmission.uuid = NSUUID().UUIDString
        }
        RLMRealm.defaultRealm().addOrUpdateObject(newSubmission)
    }
    
    //function to delete submission
    func deletePost(submission: CHPost) {
        if (submission.uuid != nil) {
            RLMRealm.defaultRealm().deleteObject(submission)
        } else {
            print("submission does not exist")
        }
    }
    
    
    //function returning entire collection
    func getAllPosts() -> RLMResults {
        return CHPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: nil)
    }

    
    
    //function returning submissions marked as accepted
    func getAllModeratedPosts() -> RLMResults {
        return CHPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = true"))
    }
    
    
    //function returning submissions ordered by acceptance time
    func getPostsAcceptanceTimeSorted() -> RLMResults {
        return CHPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = true")).sortedResultsUsingProperty("mod_acceptance_time", ascending: false)
    }
    
    
    //function returning submissions marked as NOT accepted (sorted in order of most recent submission first)
    func getAllPostsToModerate() -> RLMResults {
        return CHPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = false")).sortedResultsUsingProperty("submission_time", ascending: false)
    }
    
    /*
    //function returning most submissions ordered by most recent unacceptance first
    func getPostUnacceptanceTime() -> RLMResults {
        return STPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = false")).sortedResultsUsingProperty("mod_acceptance_time", ascending: false)
    }
    */
    
}
