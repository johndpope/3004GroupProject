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
    var server: GCDWebServer = GCDWebServer()

    public static var defaultServer = STWebServer()
    
    public override init() {
        super.init()
    }
    
    public func start() {
        server.addDefaultHandlerForMethod("GET",
                                          requestClass: GCDWebServerRequest.self,
                                          asyncProcessBlock: STRouter.defaultHandler())
        
        
        server.addHandlerForMethod("GET", path: "/",
                                   requestClass: GCDWebServerRequest.self,
                                   asyncProcessBlock: STRouter.indexHandler())
        
        
        let options: [NSObject: AnyObject] =
            [GCDWebServerOption_BonjourName: STConstBonjourName() + ".Jagger",
             //GCDWebServerOption_BonjourType: "_streamit_.tcp", // STConstBonjourType()
             GCDWebServerOption_Port: 10000,
             GCDWebServerOption_AutomaticallySuspendInBackground: false]

        do {
            try server.startWithOptions(options)
            
        } catch {
            print("We did something wrong")
        }
    }
}
