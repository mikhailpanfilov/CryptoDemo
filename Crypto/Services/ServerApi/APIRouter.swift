//
//  APIRouter.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 3/27/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var query: [String: String]? { get }
    
    func asURLRequest() throws -> URLRequest
}

enum APIRouter: URLRequestConvertible {
    case getCryptocurrencies
    case getHistory(_ params: HistoryRequest)
    
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getCryptocurrencies,
             .getHistory:
            return .get
        }
    }
    
    // MARK: Path
    var path: String {
        switch self {
        case .getCryptocurrencies:
            return "assets"
        case .getHistory(of: let params):
            return "assets/\(params.id)/history"
        }
    }
    
    // MARK: Parameters
    var parameters: Parameters? {
        switch self {
        case .getCryptocurrencies,
             .getHistory:
            return nil
        }
    }
    
    // MARK: Query
    var query: [String: String]? {
        switch self {
        case .getHistory(of: let request):
            return request.query
        default:
            return nil
        }
    }
}

extension URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        var url = try Constants.baseURL.asURL()
        
        // Query
        if let query = query, var components = URLComponents(string: url.absoluteString) {
            components.queryItems = query.map { element in URLQueryItem(name: element.key, value: element.value) }
            url = components.url!
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.coinmarketcapApiKey.rawValue, forHTTPHeaderField: HTTPHeaderField.coinmarketcapApiKey.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
