//
//  LocationSubscriber.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 21/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import CoreLocation

protocol LocationSubscriber: class {
    var didUpdateLocation: ((CLLocation?) -> Void)? { get set }
}
