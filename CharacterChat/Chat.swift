//
//  Chat.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation

class Chat {
    var friend: User
    var message: [Message]
    
    init(friend: User, message: [Message]) {
        self.friend = friend
        self.message = message
    }
}
