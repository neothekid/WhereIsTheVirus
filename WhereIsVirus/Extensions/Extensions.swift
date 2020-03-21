//
//  Extensions.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func instantiate<T: UIViewController>(from name: String) -> T? {
        UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: "\(T.self)") as? T
    }
}

extension UIView {
    static func initFromNib() -> Self? {
        guard let view = UINib(nibName: "\(self)", bundle: nil).instantiate(withOwner: self, options: [:]).first as? Self else {
            print("INCORRECT NIBNAME PROVIDED")
            return nil
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func embedd(in view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension UIColor {
    static var systemBGColor: UIColor {
        var color: UIColor = .white
        if #available(iOS 13.0, *) {
            color = .systemBackground
        }
        
        return color
    }
}
