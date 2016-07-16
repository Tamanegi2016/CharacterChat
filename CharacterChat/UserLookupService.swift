//
//  UserLookupService.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation

class UserLookupService {
    enum Error: ErrorProtocol {
        case general
    }
    
    func fetch(with keyword: String = "", page: Int = 0, complete: (result: Result<[User], Error>) -> Void) {
        let users: [User] = [
            User(identifier: "", name: "あ", profileImage: URL(string: "")!),
            User(identifier: "", name: "あい", profileImage: URL(string: "")!),
            User(identifier: "", name: "あいう", profileImage: URL(string: "")!),
            User(identifier: "", name: "あいうえ", profileImage: URL(string: "")!),
            User(identifier: "", name: "あいうえお", profileImage: URL(string: "")!),
            User(identifier: "", name: "あいうえおか", profileImage: URL(string: "")!),
            User(identifier: "", name: "あいうえおかき", profileImage: URL(string: "")!),
            User(identifier: "", name: "あいうえおかきく", profileImage: URL(string: "")!),
            User(identifier: "", name: "あいうえおかきくけ", profileImage: URL(string: "")!),
            User(identifier: "", name: "あいうえおかきくけこ", profileImage: URL(string: "")!),
        ]
        
        let filteredUsers: [User]
        if !keyword.isEmpty {
            filteredUsers = users.filter { (user) -> Bool in
                return user.name.hasPrefix(keyword)
            }
        } else {
            filteredUsers = users
        }
        
        complete(result: Result(filteredUsers))
    }
    
    deinit {
        
    }
}
