//
//  Converter.swift
//  CharacterChat
//
//  Created by Takuya Yokoyama on 2016/07/17.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation

class Converter {
    
    enum Key: String {
        case id = "id"
        case name = "name"
        case profileimage = "profileimage"
        case messageid = "messageid"
        case messagetype = "messagetype"
        case lastmessage = "lastmessage"
        case lastmessagedate = "lastmessagedate"
    }
    
    class func encode(with chats: [Chat]) -> [NSDictionary] {
        return chats
            .map { (chat) in
                return [
                    Converter.Key.id.rawValue: chat.friend.identifier,
                    Converter.Key.name.rawValue: chat.friend.name,
                    Converter.Key.profileimage.rawValue: chat.friend.profileImage.absoluteString ?? "",
                    Converter.Key.messageid.rawValue: chat.message.last?.identifier ?? "",
                    Converter.Key.messagetype.rawValue: chat.message.last?.type.rawValue ?? "",
                    Converter.Key.lastmessage.rawValue: chat.message.last?.content ?? "",
                    Converter.Key.lastmessagedate.rawValue: chat.message.last?.createdAt ?? Date()
                ]
            }
            .sorted { (dic1, dic2) -> Bool in
                guard let date1 = dic1[Converter.Key.lastmessagedate.rawValue] as? Date, date2 = dic2[Converter.Key.lastmessagedate.rawValue] as? Date else { return true }
                return date1 < date2
        }
    }

    class func decode(from message: [NSDictionary]) -> [Chat] {
        var result = [Chat]()
        for data in message {
            if let id = data[Key.id.rawValue] as? String,
                let name = data[Key.name.rawValue] as? String,
                let profileImageString = data[Key.profileimage.rawValue] as? String,
                let profileImage = URL(string: profileImageString),
                let messageId = data[Key.messageid.rawValue] as? String,
                let messageTypeString = data[Key.messagetype.rawValue] as? String,
                let messageType = Message.MessageType.init(with: messageTypeString),
                let content = data[Key.lastmessage.rawValue] as? String,
                let createdAt = data[Key.lastmessagedate.rawValue] as? Date {
                
                let user = User(identifier: id, name: name, profileImage: profileImage)
                let message = Message(identifier: messageId, type: messageType, content: content, createdAt: createdAt)
                let chat = Chat(friend: user, message: [message])
                result.append(chat)
            } else {
                continue
            }
        }
        return result
    }
    
}
