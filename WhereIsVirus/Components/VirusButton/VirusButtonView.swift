//
//  VirusButtonView.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 21/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import UIKit

class VirusButtonView: UIView {
    @IBOutlet weak var buttonBody: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var style: Style = .red
    
    var tapAction: (() -> Void)?
    
    @IBAction func tapped(_ sender: Any) {
        tapAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(style: Style, title: String, icon: UIImage?, tapAction: @escaping () -> Void) {
        self.style = style
        titleLabel.text = style == .blue ? title.uppercased() : title
        iconImage.image = icon
        self.tapAction = tapAction
        buttonBody.backgroundColor = style.color
        applyShadow()
        
        iconView.isHidden = iconImage.image == nil
        
        if style == .blue {
            titleLabel.textAlignment = .center
        }
    }
    
    private func applyShadow() {
        buttonBody.layer.cornerRadius = frame.height / 8
        buttonBody.layer.shadowColor = style.color.cgColor
        buttonBody.layer.shadowOffset = CGSize(width: 0, height: style == .blue ? 12 : 3)
        buttonBody.layer.shadowRadius = style == .blue ? 30 : 6
        buttonBody.layer.shadowOpacity = style == .blue ? 0.2 : 0.33
    }
}

extension VirusButtonView {
    enum Style: Int {
        case red, yellow, blue
        
        var color: UIColor {
            switch self {
            case .blue:
                return UIColor(red: 0.2157, green: 0.5882, blue: 0.9569, alpha: 1)
            case .red:
                return UIColor(red: 1, green: 0.1765, blue: 0.3333, alpha: 1)
            case .yellow:
                return UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)
            }
        }
    }
}
