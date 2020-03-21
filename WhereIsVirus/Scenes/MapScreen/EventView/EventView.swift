//
//  EventView.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 21/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import MapKit

class EventView: MKAnnotationView {
    @IBOutlet weak var regionImage: UIImageView!
    
    var isConfirmed: Bool = false {
        didSet {
            image = UIImage(named: (isConfirmed ? "Comfirmed" : "Self-Reported") + ".pdf")
        }
    }
}
