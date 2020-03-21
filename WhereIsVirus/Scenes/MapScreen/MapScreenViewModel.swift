//
//  MapScreenViewModel.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import XCoordinator
import CoreLocation

class MapScreenViewModel: LocationSubscriber {
    private let router: UnownedRouter<MapFlow>
    private let locationManager: LocationManager = .shared
    
    private(set) var eventLocations: [EventLocation] = []
    
    var didUpdateLocation: ((CLLocation?) -> Void)?
    
    init(router: UnownedRouter<MapFlow>) {
        self.router = router
    }
    
    func routeBack() {
        router.trigger(.dismiss)
    }
    
    func fetchEvents(completion: @escaping ([EventLocation]) -> Void) {
        VirusConnectionAPI.shared.getEvents { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            case .success(let events):
                let locations = events.allEvents.map { EventLocation(with: $0) }
                self?.eventLocations = locations
                completion(locations)
            }
        }
    }
    
    func subscribeForLocationUpdates() {
        locationManager.subscribeForUpdates(self)
    }
    
    func unsubscribeForLocationUpdates() {
        locationManager.unsubscribe(self)
    }
}
