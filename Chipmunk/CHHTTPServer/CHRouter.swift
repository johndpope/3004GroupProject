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
            print(dataReq.data)
            let newClient = CHClient()
            newClient.username = "Victor"
            
            
            print(request)
          //  GCDWebServerDataRequest
            completion(GCDWebServerDataResponse(JSONObject: ["test":123]))
            
        }
    }
}
