//
//  CurrencyServerService.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 3/27/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation
import ObjectMapper

class CurrencyServerService {
    
    typealias GetCryptocurrenciesCompletion = ([Currency]?, Error?) -> Void
    typealias GetHistoryCompletion = (History?, Error?) -> Void
    
    // MARK: Private properties
    
    private let core: ServerService
    
    // MARK: Initialization
    
    init(core: ServerService) {
        self.core = core
    }
    
    // MARK: Public methods
    
    func getCurrency(completion: @escaping GetCryptocurrenciesCompletion) {
        core.performRequest(APIRouter.getCryptocurrencies) { (result: Result<Data>) in
            switch result {
            case .success(let data):
                completion(self.parseCryptocurrencies(data: data), nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getHistory(params: HistoryRequest, completion: @escaping GetHistoryCompletion) {
        core.performRequest(APIRouter.getHistory(params)) { (result: Result<Data>) in
            switch result {
            case .success(let data):
                completion(self.parseHistory(data: data, id: params.id), nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // MARK: Private methods
    
    func parseCryptocurrencies(data: Data) -> [Currency] {
        guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: AnyObject],
            let data = jsonDict["data"] as? [[String: AnyObject]] else { return [] }
        print("Downloaded - \(data.count) objects")
        return data.compactMap { Currency(JSON: $0) }
    }
    
    func parseHistory(data: Data, id: String) -> History? {
        guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: AnyObject],
            let data = jsonDict["data"] as? [[String: AnyObject]] else { return nil }
        var pricesUsd = [String]()
        for item in data {
            if let priceUsd = item["priceUsd"] as? String {
                pricesUsd.append(priceUsd)
            }
        }
        return History(id: id, pricesUsd: pricesUsd)
    }
}
