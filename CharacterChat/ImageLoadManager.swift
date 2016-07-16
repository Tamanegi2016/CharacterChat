//
//  ImageLoadManager.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation

class ImageLoadManager {
    enum Error: ErrorProtocol {
        case general
    }
    
    let cache = Cache<NSString, NSData>()
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    static let sharedInstance = ImageLoadManager()
    
    func load(with url: URL?, complete: (result: Result<Data, Error>) -> Void) {
        guard let url = url else {
            complete(result: Result(.general))
            return
        }
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, let key = url.absoluteString else {
                complete(result: Result(.general))
                return
            }
            
            if let data = self?.cache.object(forKey: key) as? Data {
                complete(result: Result(data))
            } else {
                self?.cache.setObject(data, forKey: key)
                complete(result: Result(data))
            }
        }
        .resume()
    }
}
