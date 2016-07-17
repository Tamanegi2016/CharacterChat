//
//  Message.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation

struct Message {
    enum MessageType: String {
        case own = "own"
        case friend = "friend"
        
        /** watchでの復元用 */
        init?(with str: String) {
            switch str {
            case MessageType.own.rawValue: self = .own
            case MessageType.friend.rawValue: self = .friend
            default: return  nil
            }
        }
    }
    
    let identifier: String
    let type: MessageType
    let content: String
    let createdAt: Date
}
