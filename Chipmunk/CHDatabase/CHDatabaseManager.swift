//
//  CHDatabaseManager.swift
//  Chipmunk
//
//  Created by Ryan DiCintio on 2016-11-13.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import CHCommon

public class CHDatabaseManager {
    
    /*
     CHPOST FUNCTIONS
     */
    
    //function to add or update submission to realm
    public static func addOrUpdatePost(newSubmission: CHPost) {
        if (newSubmission.uuid == nil) {
            newSubmission.uuid = NSUUID().UUIDString
        }
        RLMRealm.defaultRealm().addOrUpdateObject(newSubmission)
    }
    
    //function to delete submission
    public static func deletePost(submission: CHPost) {
        if (submission.uuid != nil) {
            RLMRealm.defaultRealm().deleteObject(submission)
        } else {
            print("submission does not exist")
        }
    }
    
    
    //function returning entire collection
    public static func getAllPosts() -> RLMResults {
        return CHPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: nil)
    }
    
    
    
    //function returning submissions marked as accepted
    public static func getAllModeratedPosts() -> RLMResults {
        return CHPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = true"))
    }
    
    
    //function returning submissions ordered by acceptance time
    public static func getPostsAcceptanceTimeSorted() -> RLMResults {
        return CHPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = true")).sortedResultsUsingProperty("mod_acceptance_time", ascending: false)
    }
    
    
    //function returning submissions marked as NOT accepted (sorted in order of most recent submission first)
    public static func getAllPostsToModerate() -> RLMResults {
        return CHPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = false")).sortedResultsUsingProperty("submission_time", ascending: false)
    }
    
    /*
     //function returning most submissions ordered by most recent unacceptance first
     func getPostUnacceptanceTime() -> RLMResults {
     return STPost.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "mod_status = false")).sortedResultsUsingProperty("mod_acceptance_time", ascending: false)
     }
     */
    
    /*
     CHCLIENT FUNCTIONS
     */
    
    //function adding new client
    public static func addOrUpdateClient(newClient: CHClient) {
        if (newClient.uuid == nil) {
            newClient.uuid = NSUUID().UUIDString
        }
        print(newClient)
        let realm = try! Realm()
        try! realm.write {
            realm.add(newClient)
        }
    }
//    public static func addOrUpdateClient(newClient: CHClient) {
//        if (newClient.uuid == nil) {
//            newClient.uuid = NSUUID().UUIDString
//        }
//        RLMRealm.defaultRealm().addOrUpdateObject(newClient)
//    }
//    
//    //function deleting client
//    public static func deleteClient(client: CHClient) {
//        if (client.uuid != nil) {
//            RLMRealm.defaultRealm().deleteObject(client)
//        } else {
//            print("client does not exist")
//        }
//        
//    }
//    
    //function returning all existing clients in session
    public static func allClients() -> Results<CHClient> {
        let realm = try! Realm()
        let clients = realm.objects(CHClient.self)
        return clients
    }
//
//    
//    //function returning all clients sorted by username
//    public static func allClientsByName() -> RLMResults {
//        return CHClient.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: nil).sortedResultsUsingProperty("username", ascending: true)
//    }
//    
//    
//    //function returning all clients sorted by join time
//    public static func allClientsByJoinTime() -> RLMResults {
//        return CHClient.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: nil).sortedResultsUsingProperty("join_time", ascending: false)
//    }
//    
//    
//    //function returning all clients in a particular session
//    public static func allClientsInSession(id: String) -> RLMResults {
//        return CHClient.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "session_id == \(id)"))
//    }
//    
//    
//    //function returning results that have the same username
//    public static func findClientsByName(username: String) -> RLMResults {
//        return CHClient.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "username == \(username)"))
//    }
    
}
