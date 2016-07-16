//
//  InterfaceController.swift
//  CharacterChat WatchKit Extension
//
//  Created by Takuya Yokoyama on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

enum Result<T> {
    case success(T)
    case error(NSError)
}

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var table: WKInterfaceTable!
    private let session = WCSession.default()
    
    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
        startSession()
        send(with: ["message": "hello"]) { (result) in
            
        }
        loadTable()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func loadTable() {
        table.setNumberOfRows(3, withRowType: "MessageListRow")
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        super.table(table, didSelectRowAt: rowIndex)
        pushController(withName: "TalkInterfaceController", context: nil)
    }
    
    // MARK:- WCSessionDelegate
    
    private func startSession() {
        guard WCSession.isSupported() else { return }
        session.delegate = self
        session.activate()
    }
    
    private func send(with message: [String: AnyObject], completion: (result: Result<[String: AnyObject]>) -> ()) {
        guard session.isReachable else { return }
        session.sendMessage(message, replyHandler: { (replyMessage) in
            completion(result: .success(replyMessage))
        }) { (error) in
            completion(result: .error(error))
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: NSError?) {
        
    }
    
}
