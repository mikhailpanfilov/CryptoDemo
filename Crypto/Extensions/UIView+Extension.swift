//
//  UIView+Extension.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 07.10.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import UIKit

extension UIView {
    // gradient
    enum GradientPoint {
        case leftRight
        case rightLeft
        case topBottom
        case bottomTop
        case topLeftBottomRight
        case bottomRightTopLeft
        case topRightBottomLeft
        case bottomLeftTopRight
    }
    
    func addGradient(from color1: UIColor, to color2: UIColor, direction: GradientPoint, locations: [NSNumber]? = nil) {
        layer.sublayers?.forEach { sublayer in
            if sublayer.isKind(of: CAGradientLayer.classForCoder()) { sublayer.removeFromSuperlayer() }
        }
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = locations
        gradient.startPoint = gradientPoint(direction: direction).x
        gradient.endPoint = gradientPoint(direction: direction).y
        layer.insertSublayer(gradient, at: 0)
    }
    
    private func gradientPoint(direction: GradientPoint) -> (x: CGPoint, y: CGPoint) {
        switch direction {
        case .leftRight:
            return (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
        case .rightLeft:
            return (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
        case .topBottom:
            return (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
        case .bottomTop:
            return (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
        case .topLeftBottomRight:
            return (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (x: CGPoint(x: 1, y: 1), y: CGPoint(x: 0, y: 0))
        case .topRightBottomLeft:
            return (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
        case .bottomLeftTopRight:
            return (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
        }
    }
}
