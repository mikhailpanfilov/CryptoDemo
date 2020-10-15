//
//  CurrencyService.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 4/14/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation

class СurrencyService {
    
    typealias CurrencyDataHandler = ([Currency]?, Error?) -> Void
    typealias HistoryDataHandler = ([History]?, Error?) -> Void
    
    // MARK: Properties
    
    let serverService: CurrencyServerService
    var currencies: [Currency]?
    var history: [History]?
    var currencyDataHandler: CurrencyDataHandler?

    static let backgroundQueue = "com.Crypto.background.realm"
    private let operationQueue = DispatchQueue(label: backgroundQueue)
    
    // MARK: Initializing
    
    init(serverService: CurrencyServerService) {
        self.serverService = serverService
    }
    
    // MARK: Public methods
    
    func loadData() {
        fetchCurrency(completion: { [weak self] currencies in
            guard let self = self else { return }
            self.fetchHistory { [weak self] history in
                if !history.isEmpty {
                    self?.initialSync()
                } else {
                    self?.initialSync()
                }
            }
        })
    }
    
    func refreshData() {
        syncCurrency { [weak self] currencies in
            self?.currencyDataHandler?(currencies, nil)
        }
    }
    
    // MARK: Private methods
    
    private func initialSync() {
        syncCurrency { [weak self] currencies in
            self?.syncHistory(for: currencies, completion: { [weak self] history in
                self?.currencyDataHandler?(currencies, nil)
            })
        }
    }
    
    private func fetchCurrency(completion: @escaping ([Currency]) -> Void) {
        operationQueue.async {
            autoreleasepool {
                let storage: StorageContext = RealmStorageContext()
                storage.fetch(CurrencyRealm.self, predicate: nil, sorted: nil) { (currencies) in
                    let currencies = currencies.map { $0.toModel() }
                    self.currencies = currencies
                    completion(currencies)
                }
            }
        }
    }
    
    private func fetchHistory(completion: @escaping ([History]) -> Void) {
        operationQueue.async {
            autoreleasepool {
                let storage: StorageContext = RealmStorageContext()
                storage.fetch(HistoryRealm.self, predicate: nil, sorted: nil) { (history) in
                    let history = history.map { $0.toModel() }
                    self.history = history
                    completion(history)
                }
            }
        }
    }
    
    private func syncCurrency(completion: @escaping ([Currency]) -> Void) {
        loadCurrency { [weak self] (currencies, error) in
            guard let currencies = currencies else {
                // TODO: Error: Unable to sync currencies
                // TODO: Debug Error: Unable to load currencies
                return
            }
            // TODO: Delete all from database
            self?.save(currencies: currencies, completion: { currencies in
                guard let currencies = currencies else {
                    // TODO: Error: Unable to sync currencies
                    // TODO: Debug Error: Unable to save currencies to the database
                    return
                }
                self?.currencies = currencies
                completion(currencies)
            })
        }
    }
    
    private func syncHistory(for currencies: [Currency], completion: @escaping ([History]) -> Void) {
        loadHitory(for: currencies) { [weak self] (history, error) in
            guard let history = history else {
                // TODO: Error: Unable to sync history
                // TODO: Debug Error: Unable to load history
                return
            }
            // TODO: Delete all from database
            self?.save(history: history, completion: { history in
                guard let history = history else {
                    // TODO: Error: Unable to sync history
                    // TODO: Debug Error: Unable to save history to the database
                    return
                }
                self?.history = history
                completion(history)
            })
        }
    }
    
    private func loadCurrency(completion: @escaping CurrencyDataHandler) {
        serverService.getCurrency { (currencies, error) in
            if let currencies = currencies {
                completion(currencies, nil)
            } else { completion(nil, error) }
        }
    }
    
    private func loadHitory(for currencies: [Currency], completion: @escaping HistoryDataHandler) {
        var counter = 0
        var historyArray = [History]()
        let startInterval = Date().adding(hours: -20).millisecondsSince1970
        let endInterval = Date().millisecondsSince1970
        for currency in currencies {
            let params = HistoryRequest(id: currency.id, interval: .h2, start: startInterval, end: endInterval)
            serverService.getHistory(params: params) { (history, error) in
                counter += 1
                if let history = history {
                    historyArray.append(history)
                }
                if counter == currencies.count {
                    completion(historyArray, nil)
                }
            }
        }
    }
    
    private func save(currencies: [Currency], completion: @escaping ([Currency]?) -> Void) {
        operationQueue.async {
            autoreleasepool {
                let storage: StorageContext = RealmStorageContext()
                for currency in currencies {
                    let object = CurrencyRealm()
                    object.id = currency.id
                    object.name = currency.name
                    object.priceUsd = currency.priceUsd
                    object.symbol = currency.symbol
                    do {
                        try storage.save(object: object)
                    } catch {
                        completion(nil)
                    }
                }
                completion(currencies)
            }
        }
    }
    
    private func save(history: [History], completion: @escaping ([History]?) -> Void) {
        operationQueue.async {
            autoreleasepool {
                let storage: StorageContext = RealmStorageContext()
                for item in history {
                    let object = HistoryRealm()
                    object.id = item.id
                    object.pricesUsd.append(objectsIn: item.pricesUsd)
                    do {
                        try storage.save(object: object)
                    } catch {
                        completion(nil)
                    }
                }
                completion(history)
            }
        }
    }
}
