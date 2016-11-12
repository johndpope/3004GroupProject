//
//  STClients.swift
//  StreamIt
//
//  Created by Ryan DiCintio on 2016-11-10.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import Realm
import STCommon

public class STClients: RLMObject {
    var username : String?
    var uuid : String?
    var session_id : String?
    var join_time : NSDate?
    
    
    override init() {
        super.init()
    }
    
    
    //function adding new client
    func addOrUpdateClient(newClient: STClients) {
        if (newClient.uuid == nil) {
            newClient.uuid = NSUUID().UUIDString
        }
        RLMRealm.defaultRealm().addOrUpdateObject(newClient)
    }
    
    //function deleting client
    func deleteClient(client: STClients) {
        if (client.uuid != nil) {
            RLMRealm.defaultRealm().deleteObject(client)
        } else {
            print("client does not exist")
        }
        
    }
    
    //function returning all existing clients in session
    func allClients()-> RLMResults {
        return STClients.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: nil)
    }
    
    
    //function returning all clients sorted by username
    func allClientsByName() -> RLMResults {
        return STClients.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: nil).sortedResultsUsingProperty("username", ascending: true)
    }
    
    
    //function returning all clients sorted by join time
    func allClientsByJoinTime() -> RLMResults {
        return STClients.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: nil).sortedResultsUsingProperty("join_time", ascending: false)
    }
    
    
    //function returning all clients in a particular session
    func allClientsInSession(id: String) -> RLMResults {
        return STClients.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "session_id == \(id)"))
    }
    
    
    //function returning results that have the same username
    func findClientsByName(username: String) -> RLMResults {
        return STClients.objectsInRealm(RLMRealm.defaultRealm(), withPredicate: NSPredicate(format: "username == \(username)"))
    }
    
    
}

