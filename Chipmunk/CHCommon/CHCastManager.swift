//
//  CHCastManager.swift
//  Chipmunk
//
//  Created by Connor MacBook on 2016-11-14.
//  Copyright © 2016 3004Group. All rights reserved.
//

import Foundation
import GoogleCast

public class CHCastManager: NSObject, GCKDiscoveryManagerListener, GCKSessionManagerListener {
	
	var discoveryManager: GCKDiscoveryManager!
	var sessionManager: GCKSessionManager!
	
	var castSession: GCKCastSession?
	
	public var channel: CHCastChannel!
	
	public var config: CHSessionConfig?
	
	public static var sharedManager = CHCastManager()
	
	override public init() {
		super.init()
		
		self.discoveryManager = GCKCastContext.sharedInstance().discoveryManager
		self.discoveryManager.stopDiscovery() // TODO: Check later to see if this isn't needed
		self.discoveryManager.addListener(self)
		self.discoveryManager.startDiscovery()
		
		self.sessionManager = GCKCastContext.sharedInstance().sessionManager
		self.sessionManager.addListener(self)
		
		self.channel = CHCastChannel(namespace: CHConstCastNamespace())
	}
	
	public func isConnected() -> Bool {
		return self.sessionManager.hasConnectedCastSession()
	}
	
	func startCastSessionFromSession(session: GCKSession) {
		let options = GCKCastOptions(receiverApplicationID: CHConstCastAppID())
		self.castSession = GCKCastSession(device: session.device, sessionID: session.sessionID, castOptions: options)
		
		self.castSession?.start()
	}
	
	func applySettings() {
		if let configuration = self.config {
			self.channel.sendTextMessage("{\"settings\": {\"numcells\": \(configuration.numCells!), \"password\": \"\(configuration.password!)\", \"title\": \"\(configuration.title)\"}}", error: nil)
		}
	}
	
	public func didUpdateDeviceList() {
		print("Devices: \(self.discoveryManager.deviceCount)")
	}
	
	public func sessionManager(sessionManager: GCKSessionManager, willStartSession session: GCKSession) {
		print("Will start session: \(self.sessionManager.currentSession?.device.friendlyName)")
	}
	
	public func sessionManager(sessionManager: GCKSessionManager, didFailToStartSession session: GCKSession, withError error: NSError) {
		print("Failed to start session: \(session.device.friendlyName)")
	}
	
	public func sessionManager(sessionManager: GCKSessionManager, didStartSession session: GCKSession) {
		print("Session Started: \(self.sessionManager.currentSession?.device.friendlyName)")
		
		self.startCastSessionFromSession(session)
	}
	
	public func sessionManager(sessionManager: GCKSessionManager, didStartCastSession session: GCKCastSession) {
		print("Did start cast session: \(self.sessionManager.currentSession?.device.friendlyName)")
		
		session.addChannel(self.channel)
		self.applySettings()
		
		NSNotificationCenter.defaultCenter().postNotificationName(CHNotifCastSessionStarted(), object: nil)
	}
	
	public func sessionManager(sessionManager: GCKSessionManager, didEndSession session: GCKSession, withError error: NSError?) {
		print("Disconnected with error: \(error?.localizedDescription)")
		self.sessionManager.endSessionAndStopCasting(true)
	}
	
	public func sessionManager(sessionManager: GCKSessionManager, didEndCastSession session: GCKCastSession, withError error: NSError?) {
		print("Disconnected cast session")
		
		NSNotificationCenter.defaultCenter().postNotificationName(CHNotifCastSessionEnded(), object: nil)
	}
}
