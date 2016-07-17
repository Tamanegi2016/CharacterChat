//
//  UserLookupManager.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation



class UserManager {
    // TODO:- 後で削除
    static let sampleProfileImage = URL(string: "https://pbs.twimg.com/profile_images/378800000220029324/fe66faeca20115da8566e51d83447ead_400x400.jpeg")!
    
    struct Notif {
        static let willLogin = NSNotification.Name(rawValue: "willLogin")
        static let didLogin  = NSNotification.Name(rawValue: "didLogin")
        static let willLogout = NSNotification.Name(rawValue: "willLogout")
        static let didLogout  = NSNotification.Name(rawValue: "didLogout")
    }
    
    enum Error: ErrorProtocol {
        case userNotFound
        case general
    }
    
    static let sharedInstance = UserManager()
    
    private(set) var own: User?
    private(set) var frineds    = [User]()
    private(set) var chatLookup = [
        Chat(
            friend: User(identifier: "", name: "ユーザー1", profileImage: sampleProfileImage),
            message:
            [
                Message(identifier: "", type: .own, content: "こんにちわ1", createdAt: Date(timeIntervalSinceNow: -10)),
                Message(identifier: "", type: .own, content: "こんにちわ2", createdAt: Date(timeIntervalSinceNow: -5)),
                Message(identifier: "", type: .friend, content: "元気？", createdAt: Date())
            ]
        ),
        Chat(
            friend: User(identifier: "", name: "ユーザー2", profileImage: sampleProfileImage),
            message:
            [
                Message(identifier: "", type: .own, content: "おはよう1", createdAt: Date(timeIntervalSinceNow: -10)),
                Message(identifier: "", type: .own, content: "おはよう2", createdAt: Date(timeIntervalSinceNow: -5)),
                Message(identifier: "", type: .own, content: "おはよう3", createdAt: Date())
            ]
        ),
        Chat(
            friend: User(identifier: "", name: "ユーザー3", profileImage: sampleProfileImage),
            message:
            [
                Message(identifier: "", type: .own, content: "こんばんわ1", createdAt: Date(timeIntervalSinceNow: -10)),
                Message(identifier: "", type: .own, content: "こんばんわ2", createdAt: Date(timeIntervalSinceNow: -5)),
                Message(identifier: "", type: .own, content: "こんばんわ3", createdAt: Date())
            ]
        )
    ]
    
    func login(with userName: String) {
        
        NotificationCenter.default.post(name: Notif.willLogin, object: self, userInfo: nil)
        NotificationCenter.default.post(name: Notif.didLogin, object: self, userInfo: nil)
    }
    
    func logout() {
        
    }
    
    func requestChats(complate: (result: Result<[Chat], Error>) -> Void) {
        // TODO:- 後で直す
//        guard let own = own else {
//            complate(result: Result(Error.userNotFound))
//            return
//        }
        
        let mock: [Chat] = [
            Chat(
                friend: User(identifier: "", name: "ユーザー1", profileImage: UserManager.sampleProfileImage),
                message:
                [
                    Message(identifier: "", type: .own, content: "こんにちわ1", createdAt: Date(timeIntervalSinceNow: -10)),
                    Message(identifier: "", type: .own, content: "こんにちわ2", createdAt: Date(timeIntervalSinceNow: -5)),
                    Message(identifier: "", type: .own, content: "こんにちわ3", createdAt: Date())
                ]
            ),
            Chat(
                friend: User(identifier: "", name: "ユーザー2", profileImage: UserManager.sampleProfileImage),
                message:
                [
                    Message(identifier: "", type: .own, content: "おはよう1", createdAt: Date(timeIntervalSinceNow: -10)),
                    Message(identifier: "", type: .own, content: "おはよう2", createdAt: Date(timeIntervalSinceNow: -5)),
                    Message(identifier: "", type: .own, content: "おはよう3", createdAt: Date())
                ]
            ),
            Chat(
                friend: User(identifier: "", name: "ユーザー3", profileImage: UserManager.sampleProfileImage),
                message:
                [
                    Message(identifier: "", type: .own, content: "こんばんわ1", createdAt: Date(timeIntervalSinceNow: -10)),
                    Message(identifier: "", type: .own, content: "こんばんわ2", createdAt: Date(timeIntervalSinceNow: -5)),
                    Message(identifier: "", type: .own, content: "こんばんわ3", createdAt: Date())
                ]
            )
        ]
        
        chatLookup = mock
        complate(result: Result(mock))
    }
    
    func requestFriends(complate: (result: Result<[User], Error>) -> Void) {
        guard let own = own else {
            complate(result: Result(Error.userNotFound))
            return
        }
        
        complate(result: Result([User]()))
    }
}
