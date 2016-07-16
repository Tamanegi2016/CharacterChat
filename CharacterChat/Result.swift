//
//  Result.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation

enum Result<T, U where U: ErrorProtocol> {
    case success(T)
    case failure(U)
    
    init(_ data: T) {
        self = .success(data)
    }
    
    init(_ error: U) {
        self = .failure(error)
    }
}
