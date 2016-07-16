//
//  Message.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation

struct Message {
    enum MessageType {
        case Own
        case Friend
    }
    
    let identifier: String
    let type: MessageType
    let content: String
    let createdAt: Date
}
