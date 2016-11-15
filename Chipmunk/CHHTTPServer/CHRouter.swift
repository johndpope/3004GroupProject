//
//  STRouter.swift
//  StreamIt
//
//  Created by Jagger De Leo on 2016-11-12.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import GCDWebServer
import CHDatabase
import SwiftyJSON
import RealmSwift

public class CHRouter : NSObject {
    
    static func helloWorldHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
            completion(GCDWebServerDataResponse(HTML: "<html><p>Hello, World!</p></html>")!)
        }
    }
    
    static func defaultHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
            let res: GCDWebServerResponse = GCDWebServerErrorResponse(HTML: "404 Page not found")
            res.statusCode = 404
            completion(res)
        }
    }
    
    static func indexHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
            completion(GCDWebServerDataResponse(HTML:
                "<p style='font-family:sans-serif'>Let's call it Chipmunk.</p>"))
        }
    }
    
    static func clientHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
            guard let dataReq = request as? GCDWebServerDataRequest else {
                return
            }
            let json = JSON(data: dataReq.data)
            print(json.description)

            let newClient = CHClient()
            
            newClient.username = json.dictionary!["username"]?.description
            newClient.session_id = NSUUID().UUIDString
            newClient.join_time = NSDate()
            
            let resjson = JSON(newClient)
            print(resjson.description)
            CHDatabaseManager.addOrUpdateClient(newClient)
            print(CHDatabaseManager.allClients())
            
           // GCDWebServerDataResponse(JSONObject: AnyObject!)
            let dict: [String: String] = ["username": newClient.username!, "uuid": newClient.uuid!, "session_id": newClient.session_id!, "join_time": (newClient.join_time?.description)!]
            completion(GCDWebServerDataResponse(JSONObject: dict))
        }
    }
}
