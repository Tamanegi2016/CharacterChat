//
//  UserLookupManager.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation



class UserManager {
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
        NotificationCenter.default.post(name: Notif.didLogin, object: self, userInfo: nil)
    }
    
    func logout() {
        
    }
    
    func requestChats(complate: (result: Result<[Chat], Error>) -> Void) {
        guard let own = own else {
            complate(result: Result(Error.userNotFound))
            return
        }
        
        complate(result: Result([Chat]()))
    }
    
    func requestFriends(complate: (result: Result<[User], Error>) -> Void) {
        guard let own = own else {
            complate(result: Result(Error.userNotFound))
            return
        }
        
        complate(result: Result([User]()))
    }
    
    func exportChats() -> [String: AnyObject] {
        return ["data": chatLookup]
    }
}
