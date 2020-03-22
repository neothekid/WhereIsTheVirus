//
//  Events.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import MapKit

struct Events: Codable {
    let allEvents: [Event]
}

struct Event: Codable {
    let id: Int
    let occurrenceDate: Date
    let creationDate: Date
    let lastUpdateDate: Date
    let hasCough: Bool
    let hasFever: Bool
    let hasShortnessBreath: Bool
    let description: String?
    let longitude: Double
    let latitude: Double
    let confirmedBySanepid: Bool
    let address: String
    let inQuarantine: Bool
}

class EventLocation: NSObject, MKAnnotation {
    var title: String?
    let model: Event
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
    }
    
    init(with model: Event) {
        self.model = model
        super.init()
    }
}
