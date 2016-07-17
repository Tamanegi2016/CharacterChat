//
//  WatchConnectivityManager.swift
//  CharacterChat
//
//  Created by Takuya Yokoyama on 2016/07/17.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation
import WatchConnectivity

enum Result<T> {
    case success(T)
    case error(NSError)
}

class WatchConnectivityManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchConnectivityManager()
    
    private let session = WCSession.default()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            session.activate()
            session.delegate = self
        }
    }
    
    func send(with message: [String: AnyObject], completion: (result: Result<[String: AnyObject]>) -> ()) {
        guard session.isReachable else {
            let reachableError = NSError(domain: "jp.co.characterchat.reachableerror", code: 6767, userInfo: nil)
            completion(result: .error(reachableError))
            return
        }
        
        session.sendMessage(message, replyHandler: { (replyMessage) in
            completion(result: .success(replyMessage))
        }) { (error) in
            completion(result: .error(error))
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: NSError?) {
        
    }
    
}
