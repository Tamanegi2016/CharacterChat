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
    
    func fetch(with keyword: String? = nil, page: Int = 0, complete: (result: Result<[User], Error>) -> Void) {
        let users: [User] = [
            User(identifier: "", name: "テストユーザー1", profileImage: URL(string: "")!),
            User(identifier: "", name: "テストユーザー2", profileImage: URL(string: "")!),
            User(identifier: "", name: "テストユーザー3", profileImage: URL(string: "")!),
            User(identifier: "", name: "テストユーザー4", profileImage: URL(string: "")!),
            User(identifier: "", name: "テストユーザー5", profileImage: URL(string: "")!),
            User(identifier: "", name: "テストユーザー6", profileImage: URL(string: "")!),
            User(identifier: "", name: "テストユーザー7", profileImage: URL(string: "")!),
            User(identifier: "", name: "テストユーザー8", profileImage: URL(string: "")!),
            User(identifier: "", name: "テストユーザー9", profileImage: URL(string: "")!),
            User(identifier: "", name: "テストユーザー10", profileImage: URL(string: "")!),
        ]
        complete(result: Result(users))
    }
    
    deinit {
        
    }
}
