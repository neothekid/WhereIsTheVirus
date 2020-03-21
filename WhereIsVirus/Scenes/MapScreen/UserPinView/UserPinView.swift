//
//  UserPinView.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 21/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import MapKit

class UserPinView: MKAnnotationView {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        image = UIImage(named: "user loction.pdf")
    }
}
