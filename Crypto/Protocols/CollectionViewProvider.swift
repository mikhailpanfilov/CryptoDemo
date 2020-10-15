//
//  CollectionViewProvider.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 10/8/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import UIKit

protocol CollectionViewProvider: UICollectionViewDataSource, UICollectionViewDelegate { }

protocol CollectionViewProviderDelegate: class {
    func didSelectItem(at index: Int)
}
