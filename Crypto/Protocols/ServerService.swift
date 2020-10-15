//
//  ServerService.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 3/27/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation

typealias ServerResponseCompletion<T> = (Result<T>) -> Void

/// The result of response serialization.
enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol ServerService {
    func performRequest<T>(_ request: URLRequestConvertible, completion: ServerResponseCompletion<T>?)
}
