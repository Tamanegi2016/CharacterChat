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
    private var chats = [Chat]()
    private var displayChat: [Chat] {
        return chats.filter{ $0.message.last?.type == .friend }
    }
    
    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
        NotificationCenter.default.addObserver(self, selector: #selector(TalkListInterfaceController.fetch), name: NSNotification.Name("activateSuccessNotification"), object: nil)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        _ = WatchConnectivityManager.sharedManager // activate
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NotificationCenter.default.removeObserver(self)
        super.didDeactivate()
    }
    
    @objc private func fetch() {
        WatchConnectivityManager.sharedManager.send(with: ["get": "list"]) { [weak self] (result) in
            switch result {
            case .success(let result):
                if let arr = result["result"] as? [NSDictionary] {
                    let chats = Converter.decode(from: arr)
                    self?.chats = chats
                    self?.loadTable()
                }
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func loadTable() {
        DispatchQueue.main.async {
            self.table.setNumberOfRows(self.displayChat.count, withRowType: "MessageListRow")
            self.displayChat.enumerated().forEach({ (offset, chat) in
                let row = self.table.rowController(at: offset) as! MessageListRow
                row.configure(chat: chat)
            })
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        super.table(table, didSelectRowAt: rowIndex)
        pushController(withName: "TalkInterfaceController", context: chats[rowIndex])
    }
    
//    private func forceSetData() {
//        self.chats = [
//            Chat(
//                friend: User(identifier: "", name: "残念神", profileImage: URL(string: "https://pbs.twimg.com/profile_images/378800000220029324/fe66faeca20115da8566e51d83447ead_400x400.jpeg")!),
//                message: [
//                    Message(identifier: "", type: .friend, content: "エラーが発生したよ", createdAt: Date())
//                ]
//            )
//        ]
//    }
}
