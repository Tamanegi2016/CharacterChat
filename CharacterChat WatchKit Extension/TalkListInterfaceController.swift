//
//  TalkListInterfaceController.swift
//  CharacterChat WatchKit Extension
//
//  Created by Takuya Yokoyama on 2016/07/16.
//  Copyright © 2016年 Kazuhiro Hayashi All rights reserved.
//

import WatchKit
import Foundation

class TalkListInterfaceController: WKInterfaceController {
    
    @IBOutlet var table: WKInterfaceTable!
    private let manager = WatchConnectivityManager.sharedManager
    private var chats = [Chat]()
    
    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        manager.send(with: ["get": "list"]) { [weak self] (result) in
            switch result {
            case .success(let result):
                if let arr = result["result"] as? [NSDictionary] {
                    let chats = Converter.decode(from: arr)
                    self?.chats = chats
                } else {
                    self?.forceSetData()
                }
            case .error(let error):
                print(error)
                self?.forceSetData()
            }
            self?.loadTable()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func loadTable() {
        DispatchQueue.main.async {
            self.table.setNumberOfRows(self.chats.count, withRowType: "MessageListRow")
            self.chats.enumerated().forEach({ (offset, chat) in
                let row = self.table.rowController(at: offset) as! MessageListRow
                row.configure(chat: chat)
            })
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        super.table(table, didSelectRowAt: rowIndex)
        pushController(withName: "TalkInterfaceController", context: chats[rowIndex])
    }
    
    private func forceSetData() {
        self.chats = [
            Chat(
                friend: User(identifier: "", name: "ありさ", profileImage: URL(string: "https://pbs.twimg.com/profile_images/378800000220029324/fe66faeca20115da8566e51d83447ead_400x400.jpeg")!),
                message: [
                    Message(identifier: "", type: .friend, content: "おはよう", createdAt: Date())
                ]
            )
        ]
    }
}
