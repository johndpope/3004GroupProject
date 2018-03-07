//
//  CHCastManager.swift
//  Chipmunk
//
//  Created by Connor MacBook on 2016-11-14.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import GoogleCast

open class CHCastManager: NSObject, GCKDiscoveryManagerListener, GCKSessionManagerListener {
	
	var discoveryManager: GCKDiscoveryManager!
	var sessionManager: GCKSessionManager!
	
	var castSession: GCKCastSession?
	
	open var channel: CHCastChannel!
	
	open var config: CHSessionConfig?
	
	open static var sharedManager = CHCastManager()
	
	override public init() {
		super.init()
		
		self.discoveryManager = GCKCastContext.sharedInstance().discoveryManager
		self.discoveryManager.stopDiscovery() // TODO: Check later to see if this isn't needed
		self.discoveryManager.add(self)
		self.discoveryManager.startDiscovery()
		
		self.sessionManager = GCKCastContext.sharedInstance().sessionManager
		self.sessionManager.add(self)
		
		self.channel = CHCastChannel(namespace: CHConstCastNamespace())
	}
	
	open func isConnected() -> Bool {
		return self.sessionManager.hasConnectedCastSession()
	}
	
	func startCastSessionFromSession(_ session: GCKSession) {
		let options = GCKCastOptions(receiverApplicationID: CHConstCastAppID())
		self.castSession = GCKCastSession(device: session.device, sessionID: session.sessionID, castOptions: options)
		
		self.castSession?.start()
	}
	
	func applySettings() {
		if let configuration = self.config {
			self.channel.sendTextMessage("{\"settings\": {\"numcells\": \(configuration.numCells!), \"password\": \"\(configuration.password!)\", \"title\": \"\(configuration.title)\"}}", error: nil)
		}
	}
	
	open func didUpdateDeviceList() {
		print("Devices: \(self.discoveryManager.deviceCount)")
	}
	
	open func sessionManager(_ sessionManager: GCKSessionManager, willStart session: GCKSession) {
		print("Will start session: \(self.sessionManager.currentSession?.device.friendlyName)")
	}
	
	open func sessionManager(_ sessionManager: GCKSessionManager, didFailToStart session: GCKSession, withError error: NSError) {
		print("Failed to start session: \(session.device.friendlyName)")
	}
	
	open func sessionManager(_ sessionManager: GCKSessionManager, didStart session: GCKSession) {
		print("Session Started: \(self.sessionManager.currentSession?.device.friendlyName)")
		
		self.startCastSessionFromSession(session)
	}
	
	open func sessionManager(_ sessionManager: GCKSessionManager, didStart session: GCKCastSession) {
		print("Did start cast session: \(self.sessionManager.currentSession?.device.friendlyName)")
		
		session.add(self.channel)
		self.applySettings()
		
		NotificationCenter.default.post(name: Notification.Name(rawValue: CHNotifCastSessionStarted()), object: nil)
	}
	
	open func sessionManager(_ sessionManager: GCKSessionManager, didEnd session: GCKSession, withError error: NSError?) {
		print("Disconnected with error: \(error?.localizedDescription)")
		self.sessionManager.endSessionAndStopCasting(true)
	}
	
    open func sessionManager(_ sessionManager: GCKSessionManager, didEnd session: GCKCastSession, withError error: Error?) {
		print("Disconnected cast session")
		
		NotificationCenter.default.post(name: Notification.Name(rawValue: CHNotifCastSessionEnded()), object: nil)
	}
}
