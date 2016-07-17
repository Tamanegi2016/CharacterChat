//
//  ImageLoadManager.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/17.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation

class ImageLoadManager {
    enum Error: ErrorProtocol {
        case general
    }
    
    let cache = Cache<NSString, NSData>()
    
    
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
    
    static let sharedInstance = ImageLoadManager()
    
    func load(with url: URL?, complete: (result: Result<Data, Error>) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let url = url, let urlString = url.absoluteString else {
                complete(result: Result(.general))
                return
            }
            
            if let data = self?.cache.object(forKey: urlString) as? Data {
                complete(result: Result(data))
            } else {
                let task = self?.session.dataTask(with: url) { [weak self] (data, response, error) in
                    guard let data = data else {
                        complete(result: Result(.general))
                        return
                    }
                    
                    self?.cache.setObject(data, forKey: urlString)
                    complete(result: Result(data))
                }
                task?.resume()
            }
        }
        
        
    }
}
