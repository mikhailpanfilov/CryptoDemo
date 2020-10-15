//
//  GraphView.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 04.10.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    /// gap between each point
    let lineGap: CGFloat = 6.0
    
    /// preseved space at top of the chart
    let topSpace: CGFloat = 0.0
    
    /// preserved space at bottom of the chart to show labels along the Y axis
    let bottomSpace: CGFloat = 0.0
    
    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 110.0 / 100.0
    
    var dataEntries: [Double]? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// Contains the main line which represents the data
    private let dataLayer: CALayer = CALayer()
    
    /// To show the gradient below the main line
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    /// Contains dataLayer and gradientLayer
    private let mainLayer: CALayer = CALayer()
    
    private var graphPath = UIBezierPath()
    
    /// An array of CGPoint on dataLayer coordinate system that the main line will go through. These points will be calculated from dataEntries array
    private var dataPoints: [CGPoint]?

    private let curveAlgorithm = CurveAlgorithm()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        gradientLayer.colors = [UIColor.gradientFrom.cgColor, UIColor.gradientTo.cgColor]
        layer.addSublayer(mainLayer)
        layer.addSublayer(gradientLayer)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        gradientLayer.colors = [UIColor.gradientFrom.cgColor, UIColor.gradientTo.cgColor]
    }
    
    override func layoutSubviews() {
        if let dataEntries = dataEntries {
            mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
            dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
            gradientLayer.frame = dataLayer.frame
            gradientLayer.frame.size.height = mainLayer.frame.size.height + 10
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            dataPoints = convertDataEntriesToPoints(entries: dataEntries)
            clean()
            drawCurvedChart()
            maskGradientLayer()
        }
    }
    
    private func convertDataEntriesToPoints(entries: [Double]) -> [CGPoint] {
        guard let max = entries.max(), let min = entries.min() else { return [] }
        var result: [CGPoint] = []
        let minMaxRange: CGFloat = CGFloat(max - min) * topHorizontalLine
        
        for i in 0..<entries.count {
            let height = dataLayer.frame.height * (1 - ((CGFloat(entries[i]) - CGFloat(min)) / minMaxRange))
            let point = CGPoint(x: CGFloat(i) * lineGap, y: height)
            result.append(point)
        }
        return result
    }
    
    private func drawCurvedChart() {
        guard let dataPoints = dataPoints, dataPoints.count > 0, let path = curveAlgorithm.createCurvedPath(dataPoints) else { return }
        graphPath = path
    }
    
    private func maskGradientLayer() {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else { return }
        let mask = CAShapeLayer()
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = 1.0
        mask.path = graphPath.cgPath
        gradientLayer.mask = mask
    }
    
    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
}
