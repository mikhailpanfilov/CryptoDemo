//
//  PriceCollectionViewCell.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 10/8/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell {

    static let height: CGFloat = 64.0
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceDecimalLabel: UILabel!
    @IBOutlet weak var graphView: GraphView!
    
    func populate(with item: PriceCellItem) {
        symbolLabel.text = item.symbol
        nameLabel.text = item.name.uppercased()
        let priceComponents = item.priceUsd.components(separatedBy: ".")
        let currencyPrice = Float(item.priceUsd) ?? 0
        priceLabel.text = currencyPrice < 0.01 ? "<\(priceComponents[0])" : "\(priceComponents[0])".comaFormatted
        if let decimalPrice = priceComponents[item: 1] {
            priceDecimalLabel.text = "." + (currencyPrice < 0.01 ? "01" : decimalPrice.prefix(2))
        }
        graphView.dataEntries = item.priceHistory?.compactMap { Double($0) }
    }
}
