//
//  ViewWithGradient.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import UIKit

class ViewWithGradient: UIView {
    private var gradientColors: [UIColor]?
    private var startPoint: CGPoint?
    private var endPoint: CGPoint?
    private var gradientLayer: CAGradientLayer?
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setNeedsLayout()
        applyGradient()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configure(gradientColors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        self.gradientColors = gradientColors
        self.startPoint = startPoint
        self.endPoint = endPoint
        
        if gradientLayer == nil {
            applyGradient()
        }
    }
    
    private func setupView() {
        applyGradient()
    }
    
    private func applyGradient() {
        guard let colors = gradientColors, let start = startPoint, let end = endPoint else {
            return
        }
        
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = frame
        gradientLayer?.colors = colors.map { $0.cgColor }
        gradientLayer?.startPoint = start
        gradientLayer?.endPoint = end
        layer.insertSublayer(gradientLayer!, at: 0)
    }
}
