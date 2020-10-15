//
//  CurrencyPresenter.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/2/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyOutput: class {
    func onSelected(item: Currency)
}

class CurrencyPresenter {
    
    // MARK: Properties
    
    private weak var view: CurrencyInterface!
    private weak var output: CurrencyOutput!
    private let currencyService: СurrencyService
    private lazy var collectionViewProvider: CurrencyCollectionViewProvider = {
        var collectionViewProvider = CurrencyCollectionViewProvider()
        collectionViewProvider.delegate = self
        return collectionViewProvider
    }()
    
    // MARK: Initializers
    
    required init(view: CurrencyInterface, currencyService: СurrencyService) {
        self.view = view
        self.currencyService = currencyService
        checkCryptocurrencyDataLoading()
    }
    
    // MARK: Public methods
    
    func set(_ output: CurrencyOutput) {
        self.output = output
    }
    
    // MARK: Private methods
    
    private func checkCryptocurrencyDataLoading() {
        currencyService.currencyDataHandler = { [weak self] (cryptocurrencies, error) in
            DispatchQueue.main.async {
                guard let сurrencies = cryptocurrencies, let self = self else { return print("Error: \(String(describing: error?.localizedDescription))") }
                // TODO: Create empty state view
                if !сurrencies.isEmpty {
                    var priceCellItems = [PriceCellItem]()
                    for (index, currency) in сurrencies.enumerated() {
                        priceCellItems.append(PriceCellItem(name: currency.name, symbol: currency.symbol, priceUsd: currency.priceUsd, priceHistory: self.currencyService.history?.first(where: { $0.id == currency.id })?.pricesUsd))
                    }
                    self.collectionViewProvider.data = priceCellItems
                    self.view.reloadData()
                } else { print("Empty view state") }
            }
        }
    }
}

// MARK: CurrencyPresentation

extension CurrencyPresenter: CurrencyPresentation {
    func onViewDidLoad() {
        view.setCollectionView(provider: collectionViewProvider)
        currencyService.loadData()
    }
    
    func onRefreshAction() {
        currencyService.refreshData()
    }
}

extension CurrencyPresenter: PriceCollectionViewProviderDelegate {
    func didSelectItem(at index: Int) {
        guard let currencies = currencyService.currencies else { return }
        output.onSelected(item: currencies[index])
    }
    
    func scrollViewDidEndScrolling(with contentOffset: CGPoint) { }
}
