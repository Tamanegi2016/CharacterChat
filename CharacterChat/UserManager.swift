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
    let sampleProfileImage = URL(string: "https://pbs.twimg.com/profile_images/378800000220029324/fe66faeca20115da8566e51d83447ead_400x400.jpeg")!
    
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
    
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
    private(set) var chatLookup = [Chat]()
    
    func login(with userName: String) {
        
        NotificationCenter.default.post(name: Notif.willLogin, object: self, userInfo: nil)
        
        let encodedUserName = userName.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        let task = session.dataTask(with: URL(string: "http://0.0.0.0:3000/get_users_from_name?user_name=\(encodedUserName)")!) { [weak self] (data, response, error) in
            guard let data = data else {
                return
            }
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers), let aryObj = jsonObj as? NSArray {
                if let dictObj = aryObj.firstObject as? NSDictionary,
                    name = dictObj["name"] as? String,
                    identifier = dictObj["id"] as? Int,
                    profileUrl = dictObj["profile_url"] as? String {
                    self?.own = User(identifier: "\(identifier)", name: name, profileImage: URL(string: profileUrl)!)
                }
                NotificationCenter.default.post(name: Notif.didLogin, object: self, userInfo: nil)
            }
            
            
        }
        
        task.resume()

        
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
                friend: User(identifier: "", name: "ユーザー1", profileImage: sampleProfileImage),
                message:
                [
                    Message(identifier: "", type: .own, content: "こんにちわ1", createdAt: Date(timeIntervalSinceNow: -10)),
                    Message(identifier: "", type: .own, content: "こんにちわ2", createdAt: Date(timeIntervalSinceNow: -5)),
                    Message(identifier: "", type: .own, content: "こんにちわ3", createdAt: Date())
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
        
        chatLookup = mock
        complate(result: Result(mock))
    }
    
    func requestFriends(complate: (result: Result<[User], Error>) -> Void) {
        guard let own = own else {
            complate(result: Result(Error.userNotFound))
            return
        }
        
        let task = session.dataTask(with: URL(string: "http://0.0.0.0:3000/friendlist/\(own.identifier)")!) { (data, response, error) in
            guard let data = data else {
                complate(result: Result(Error.userNotFound))
                return
            }
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers), let aryObj = jsonObj as? NSArray {
                var friends = [User]()
                for friendObj in aryObj {
                    if let dictObj = friendObj as? NSDictionary,
                        name = dictObj["name"] as? String,
                        identifier = dictObj["id"] as? Int,
                        profileUrl = dictObj["profile_url"] as? String {
                        friends.append(User(identifier: "\(identifier)", name: name, profileImage: URL(string: profileUrl)!))
                    }
                }
                complate(result: Result(friends))
            } else {
                complate(result: Result(Error.userNotFound))
            }
            
            
        }
        
        task.resume()
        
    }
    
    func addFriend(userId: String, complete: (success: Bool) -> Void) {
                guard let own = own else {
                    complete(success: false)
                    return
                }

        var request = URLRequest(url: URL(string: "http://0.0.0.0:3000/friend/\(own.identifier)/\(userId)")!)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                complete(success: false)
            } else {
                complete(success: true)
            }
        }
        
        task.resume()
    }
    
    func message(to userId: String, content: String, complete: (success: Bool) -> Void) {
                guard let own = own else {
                    complete(success: false)
                    return
                }
        
        let encodedContent = content.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        var request = URLRequest(url: URL(string: "http://0.0.0.0:3000/talk/\(own.identifier)/\(userId)/\(encodedContent)")!)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                complete(success: false)
            } else {
                complete(success: true)
            }
        }
        
        task.resume()
    }
}
