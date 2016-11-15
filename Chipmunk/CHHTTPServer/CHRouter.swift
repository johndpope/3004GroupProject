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
import CHCommon
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
    
//    static func clientHandler() -> GCDWebServerAsyncProcessBlock {
//        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
//            guard let dataReq = request as? GCDWebServerDataRequest else {
//                return
//            }
//            let json = JSON(data: dataReq.data)
//            let newClient = CHClient()
//            
//            newClient.username = json.dictionary!["username"]?.string
//            newClient.session_id = NSUUID().UUIDString
//            newClient.join_time = NSDate()
//            
//            CHDatabaseManager.addOrUpdateClient(newClient)
//            
//            let dict: [String: String] = ["username": newClient.username!,
//                                          "uuid": newClient.uuid!,
//                                          "session_id": newClient.session_id!,
//                                          "join_time": (newClient.join_time?.description)!]
//            
//            completion(GCDWebServerDataResponse(JSONObject: dict))
//        }
//    }
	
    static func postHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
            guard let dataReq = request as? GCDWebServerDataRequest else {
                return
            }
            let json = JSON(data: dataReq.data)
            
            // at some point we'll need to check this so we don't break everything on each bad req
            // json.dictionaryObject?.contains(<#T##predicate: ((String, AnyObject)) throws -> Bool##((String, AnyObject)) throws -> Bool#>)
            
			let dict: [String: AnyObject] = ["content": ["src": (json.dictionary!["body"]?.stringValue)!,
                                             "type": (json.dictionary!["post_type"]?.stringValue)!]]
			
			let castJSON = JSON(dict)
			
			dispatch_async(dispatch_get_main_queue(), {() in
				let castManager = CHCastManager.sharedManager
				
				if (castManager.isConnected()) {
					castManager.channel.sendTextMessage(castJSON.rawString()!, error: nil)
				}
				
				completion(GCDWebServerDataResponse(JSONObject: dict))
			})
        }
    }
}
