//
//  STHTTPServer.swift
//  StreamIt
//
//  Created by Jagger De Leo on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import GCDWebServer
import STCommon

public class STWebServer: NSObject {
    let server: GCDWebServer = GCDWebServer()
    
    public override init() {
        super.init()
    }
    
    public func start() {
        server.addDefaultHandlerForMethod("GET",
                                          requestClass: GCDWebServerRequest.self,
                                          asyncProcessBlock: {(request: GCDWebServerRequest!, completion: GCDWebServerCompletionBlock!) in
                                            completion(GCDWebServerDataResponse(HTML: "<html><p>Hello, World!</p></html>")!)
                                          })
        
        server.startWithPort(10000, bonjourName: STConstBonjourName())
        print("hello?")
    }
}
