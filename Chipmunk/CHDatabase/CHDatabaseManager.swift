//
//  CHDatabaseManager.swift
//  Chipmunk
//
//  Created by Ryan DiCintio on 2016-11-13.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import RealmSwift
import CHCommon

open class CHDatabaseManager {
    static let realm = try! Realm()
    static let defaultManager = CHDatabaseManager()
    
    //function to add or update submission to realm
    open static func addOrUpdatePost(_ newSubmission: CHPost) {
        if (newSubmission.uuid == nil) {
            newSubmission.uuid = UUID().uuidString
        }
        print(newSubmission)
        try! self.realm.write {
            self.realm.add(newSubmission)
        }
    }
    
    //function to delete submission
    open static func deletePost(_ submission: CHPost) {
        if (submission.uuid != nil) {
            self.realm.delete(submission)
        } else {
            print("submission does not exist")
        }
    }
    
    //function returning entire collection
    open static func getAllPosts() -> Results<CHPost> {
        let posts = self.realm.objects(CHPost.self)
        return posts
    }
    
    //function returning submissions marked as accepted
    open static func getAllModeratedPosts() -> Results<CHPost> {
        let posts = self.realm.objects(CHPost.self)
        return posts.filter("mod_status = 'true'")
    }
    
    
    //function returning submissions ordered by acceptance time
    open static func getPostsAcceptanceTimeSorted() -> Results<CHPost> {
        let posts = self.realm.objects(CHPost.self)
        return posts.sorted(byKeyPath: "mod_acceptance_time", ascending: false)
    }
    
    
    //function returning submissions marked as NOT accepted (sorted in order of most recent submission first)
    open static func getAllPostsToModerate() -> Results<CHPost> {
        let posts = self.realm.objects(CHPost.self)
        return posts.sorted(byKeyPath: "submission_time", ascending: false)
    }

    //function adding new client
    open static func addOrUpdateClient(_ newClient: CHClient) {
        if (newClient.uuid == nil) {
            newClient.uuid = UUID().uuidString
        }
        print(newClient)
        try! self.realm.write {
            self.realm.add(newClient)
        }
    }
    
    //function deleting client
    open static func deleteClient(_ client: CHClient) {
        if (client.uuid != nil) {
            self.realm.delete(client)
        } else {
            print("client does not exist")
        }
    }
    
    //function returning all existing clients in session
    open static func allClients() -> Results<CHClient> {
        return self.realm.objects(CHClient.self)
    }
    
    //function returning all clients sorted by username
    open static func allClientsByName() -> Results<CHClient> {
        let clients = self.realm.objects(CHClient.self)
        return clients.sorted(byKeyPath: "name", ascending: true)
    }
    
    //function returning all clients sorted by join time
    open static func allClientsByJoinTime() -> Results<CHClient> {
        let clients = self.realm.objects(CHClient.self)
        return clients.sorted(byKeyPath: "join_time", ascending: false)
    }
    
    //function returning all clients in a particular session
    open static func allClientsInSession(_ id: String) -> Results<CHClient> {
        let clients = self.realm.objects(CHClient.self)
        return clients.filter("session_id = '\(id)'")
    }

    //function returning results that have the same username
    open static func findClientsByName(_ username: String) -> Results<CHClient> {
        let clients = self.realm.objects(CHClient.self)
        return clients.filter("username = '\(username)'")
    }
}
