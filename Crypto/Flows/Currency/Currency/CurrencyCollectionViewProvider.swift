//
//  CurrencyCollectionViewProvider.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 10/8/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import UIKit

protocol PriceCollectionViewProviderDelegate: CollectionViewProviderDelegate {
    func scrollViewDidEndScrolling(with contentOffset: CGPoint)
}

protocol PriceCollectionViewProviderDataSource: class { }

class CurrencyCollectionViewProvider: NSObject, CollectionViewProvider {
    
    var data = [PriceCellItem]()
    weak var delegate: PriceCollectionViewProviderDelegate!
    weak var dataSource: PriceCollectionViewProviderDataSource!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCollectionViewCell.identifier, for: indexPath) as! PriceCollectionViewCell
        cell.populate(with: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndScrolling(with: scrollView.contentOffset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            delegate?.scrollViewDidEndScrolling(with: scrollView.contentOffset)
        }
    }
}
