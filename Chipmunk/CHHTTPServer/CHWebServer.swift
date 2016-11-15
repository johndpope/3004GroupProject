//
//  STHTTPServer.swift
//  StreamIt
//
//  Created by Jagger De Leo on 2016-11-11.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import GCDWebServer
import CHCommon
//import Realm
import RealmSwift

public class CHWebServer: NSObject {
    var server: GCDWebServer = GCDWebServer()

    public static var defaultServer = CHWebServer()
    
    public override init() {
        super.init()
    }
    
    public func start() {
        
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}})
        
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
        
        
        server.addDefaultHandlerForMethod("GET",
                                          requestClass: GCDWebServerRequest.self,
                                          asyncProcessBlock: CHRouter.defaultHandler())
        
        
        server.addHandlerForMethod("GET", path: "/",
                                   requestClass: GCDWebServerRequest.self,
                                   asyncProcessBlock: CHRouter.indexHandler())

        server.addHandlerForMethod("POST", path: "/client/register", requestClass: GCDWebServerDataRequest.self,
                                   asyncProcessBlock: CHRouter.clientHandler())
        
        let options: [NSObject: AnyObject] =
            [GCDWebServerOption_BonjourName: CHConstBonjourName() + ".Jagger",
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
