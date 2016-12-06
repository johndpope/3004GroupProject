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

public class CHDatabaseManager {
	
	let realm = try! Realm()
	
    public static let defaultManager = CHDatabaseManager()
    
    //function to add or update submission to realm
    public func addOrUpdatePost(newSubmission: CHPost) {
        if (newSubmission.uuid == nil) {
            newSubmission.uuid = NSUUID().UUIDString
        }
       
        try! self.realm.write {
            self.realm.add(newSubmission)
        }
    }
    
    //function returning entire collection
    public func getAllPosts() -> Results<CHPost> {
        let posts = self.realm.objects(CHPost.self)
        return posts
    }
    
    //function returning submissions marked as accepted
    public func getAllModeratedPosts() -> Results<CHPost> {
        let posts = self.realm.objects(CHPost.self)
        return posts.filter("mod_status = 'true'")
    }
    
    
    //function returning submissions ordered by acceptance time
    public func getPostsAcceptanceTimeSorted() -> Results<CHPost> {
        let posts = self.realm.objects(CHPost.self)
        return posts.sorted("mod_acceptance_time", ascending: false)
    }
    
    
    //function returning submissions marked as NOT accepted (sorted in order of most recent submission first)
    public func getAllPostsToModerate() -> Results<CHPost> {
        let posts = self.realm.objects(CHPost.self)
        return posts.filter("mod_status = false").sorted("submission_time", ascending: false)
    }
	
	public func deletePost(uuid: String) {
		let post = self.realm.objectForPrimaryKey(CHPost.self, key: uuid)!
		
		do {
			try self.realm.write {
				self.realm.delete(post)
			}
		}
		catch {
			let err = error as NSError
			print(err.localizedDescription)
		}
		
		NSNotificationCenter.defaultCenter().postNotificationName(CHNotifPostsToModerateChanged(), object: nil)
	}
	
	public func setPostAccepted(uuid: String) {
		let post = self.realm.objectForPrimaryKey(CHPost.self, key: uuid)!
		
		do {
			try self.realm.write {
				post.mod_status = true
			}
		}
		catch {
			let err = error as NSError
			print(err.localizedDescription)
		}
		
		NSNotificationCenter.defaultCenter().postNotificationName(CHNotifPostsToModerateChanged(), object: nil)
	}

    //function adding new client
    public func addOrUpdateClient(newClient: CHClient) {
        if (newClient.uuid == nil) {
            newClient.uuid = NSUUID().UUIDString
        }
        print(newClient)
        try! self.realm.write {
            self.realm.add(newClient)
        }
    }
    
    //function deleting client
    public func deleteClient(client: CHClient) {
        if (client.uuid != nil) {
            self.realm.delete(client)
        } else {
            print("client does not exist")
        }
    }
    
    //function returning all existing clients in session
    public func allClients() -> Results<CHClient> {
        return self.realm.objects(CHClient.self)
    }
    
    //function returning all clients sorted by username
    public func allClientsByName() -> Results<CHClient> {
        let clients = self.realm.objects(CHClient.self)
        return clients.sorted("name", ascending: true)
    }
    
    //function returning all clients sorted by join time
    public func allClientsByJoinTime() -> Results<CHClient> {
        let clients = self.realm.objects(CHClient.self)
        return clients.sorted("join_time", ascending: false)
    }
    
    //function returning all clients in a particular session
    public func allClientsInSession(id: String) -> Results<CHClient> {
        let clients = self.realm.objects(CHClient.self)
        return clients.filter("session_id = '\(id)'")
    }

    //function returning results that have the same username
    public func findClientsByName(username: String) -> Results<CHClient> {
        let clients = self.realm.objects(CHClient.self)
        return clients.filter("username = '\(username)'")
    }
}
