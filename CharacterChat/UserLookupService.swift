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
    
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
    
    func fetch(with keyword: String = "", page: Int = 0, complete: (result: Result<[User], Error>) -> Void) -> URLSessionTask {
        let encodedUserName = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        let task = session.dataTask(with: URL(string: "http://0.0.0.0:3000/search_users?query=\(encodedUserName)")!) { (data, response, error) in
            guard let data = data else {
                complete(result: Result(Error.general))
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
                complete(result: Result(friends))
            } else {
                complete(result: Result(Error.general))
            }
            
            
        }
        
        task.resume()
        
        return task
    }
    
    deinit {
        
    }
}
