//
//  GradientView.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 07.10.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var colorFrom: UIColor = .bottomGradientFrom
    var colorTo: UIColor = .bottomGradientTo
    var locations: [NSNumber]? = nil
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupView()
    }
    
    // MARK: Private methods
    
    private func setupView() {
        addGradient(from: colorFrom, to: colorTo, direction: .topBottom, locations: locations)
    }
}
