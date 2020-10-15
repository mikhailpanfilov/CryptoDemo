//
//  URLSessionService.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 3/27/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation
import Alamofire


class URLSessionService: ServerService {

    func performRequest<T>(_ request: URLRequestConvertible, completion: ServerResponseCompletion<T>?) {
        Alamofire.request(try! request.asURLRequest()).responseData { (responseData) in
            var result: Result<T>
            defer {
                completion?(result)
            }
            if let response = responseData.response, 200...299 ~= response.statusCode {
                guard let data = responseData.data as? T else { return result = .failure(HTTPRequestError.invalidResponseDataType) }
                result = .success(data)
            } else {
                result = .failure(responseData.error ?? HTTPRequestError.invalidResponse)
            }
        }
    }
}

extension URLSessionService {
    enum HTTPRequestError: Error {
        case invalidResponseDataType
        case invalidResponse
        case custom(String)
        
        var localizedDescription: String {
            switch self {
            case .invalidResponseDataType:
                return "Response's data format is different from expected."
            case .invalidResponse:
                return "Invalid response."
            case .custom(let value):
                return value
            }
        }
    }
}
