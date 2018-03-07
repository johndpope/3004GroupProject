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
import RealmSwift

open class CHWebServer: NSObject {
    var server: GCDWebServer = GCDWebServer()

    open static var defaultServer = CHWebServer()
    
    public override init() {
        super.init()
    }
    
    open func start() {
        
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}})
        
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
        
        
        server.addDefaultHandler(forMethod: "GET",
                                          request: GCDWebServerRequest.self,
                                          asyncProcessBlock: CHRouter.defaultHandler())
        
        
        server.addHandler(forMethod: "GET", path: "/",
                                   request: GCDWebServerRequest.self,
                                   asyncProcessBlock: CHRouter.indexHandler())

        server.addHandler(forMethod: "POST", path: "/client/register",
                                   request: GCDWebServerDataRequest.self,
                                   asyncProcessBlock: CHRouter.clientHandler())

        server.addHandler(forMethod: "POST", path: "/post",
                                   request: GCDWebServerDataRequest.self,
                                   asyncProcessBlock: CHRouter.postHandler())
        
        let options: [AnyHashable: Any] =
            [GCDWebServerOption_BonjourName: CHConstBonjourName() + ".Jagger",
             //GCDWebServerOption_BonjourType: "_streamit_.tcp", // STConstBonjourType()
             GCDWebServerOption_Port: 10000,
             GCDWebServerOption_AutomaticallySuspendInBackground: false]

        do {
            try self.server.start(options: options)
            
        } catch {
            print("We did something wrong")
        }
    }
	
	open func stop() {
		self.server.stop()
	}
}
