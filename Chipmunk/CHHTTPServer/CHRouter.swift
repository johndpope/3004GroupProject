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
import CHCommon

open class CHRouter : NSObject {
    
    static func helloWorldHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
            completion(GCDWebServerDataResponse(html: "<html><p>Hello, World!</p></html>")!)
        }
    }
    
    static func defaultHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
            let res: GCDWebServerResponse = GCDWebServerErrorResponse(html: "404 Page not found")!
            res.statusCode = 404
            completion(res)
        }
    }
    
    static func indexHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
            completion(GCDWebServerDataResponse(html:
                "<p style='font-family:sans-serif'>Let's call it Chipmunk.</p>"))
        }
    }
    
    static func clientHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
            DispatchQueue.main.async(execute: {() in
                guard let dataReq = request as? GCDWebServerDataRequest else {
                    return
                }
                
                var  json = try! JSON(data: dataReq.data)
               
                
                let newClient = CHClient()
                
                newClient.username = json.dictionary!["username"]?.string
                newClient.session_id = UUID().uuidString
                newClient.join_time = Date()
                
                CHDatabaseManager.addOrUpdateClient(newClient)
                
                let dict: [String: String] = ["username": newClient.username!,
                                              "uuid": newClient.uuid!,
                                              "session_id": newClient.session_id!,
                                              "join_time": (newClient.join_time?.description)!]
                
                completion(GCDWebServerDataResponse(jsonObject: dict))
                } as @convention(block) () -> Void)
        }
    }
	
    static func postHandler() -> GCDWebServerAsyncProcessBlock {
        return {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
			
            //              let castJSON = JSON(dict)
            //				let castManager = CHCastManager.sharedManager
            //
            //				if (castManager.isConnected()) {
            //					castManager.channel.sendTextMessage(castJSON.rawString()!, error: nil)
            //				}
            
            
			DispatchQueue.main.async(execute: {() in
                guard let dataReq = request as? GCDWebServerDataRequest else {
                    return
                }
                let json = try! JSON(data: dataReq.data)
                
                // at some point we'll need to check this so we don't break everything on each bad req
                // json.dictionaryObject?.contains(<#T##predicate: ((String, AnyObject)) throws -> Bool##((String, AnyObject)) throws -> Bool#>)
                
                let dict: [String: Any] = ["content": ["src": (json.dictionary!["body"]?.stringValue)!,
                    "type": (json.dictionary!["post_type"]?.stringValue)!]]
                
                let post = CHPost()
                post.body = json.dictionaryValue["body"]?.string as! NSString
                post.post_type = CHPostType.init(rawValue: json.dictionaryValue["post_type"]!.intValue)

                CHDatabaseManager.addOrUpdatePost(post)
                
                // this should probably return something more useful to the client devices
				completion(GCDWebServerDataResponse(jsonObject: dict))
			})
        }
    }
}
