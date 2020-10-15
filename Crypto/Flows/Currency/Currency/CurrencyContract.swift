//
//  PriceListContract.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/2/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import Foundation

protocol CurrencyInterface: class {
    func setCollectionView(provider: CurrencyCollectionViewProvider)
    func reloadData()
}

protocol CurrencyPresentation: class {
    func onViewDidLoad()
    func onRefreshAction()
}
