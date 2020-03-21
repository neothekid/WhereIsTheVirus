//
//  LocationManager.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 21/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import CoreLocation
import UserNotifications

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private let center = UNUserNotificationCenter.current()
    private let locationManager = CLLocationManager()
    private var subscribers: [LocationSubscriber] = []
    
    var currentLocation: CLLocation? {
        locationManager.location
    }
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
    
    func subscribeForUpdates(_ subscriber: LocationSubscriber) {
        subscribers.append(subscriber)
    }
    
    func unsubscribe(_ subscriber: LocationSubscriber) {
        subscribers.removeAll { "\(String(describing: $0))" == "\(String(describing: subscriber))" }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        subscribers.forEach { $0.didUpdateLocation?(manager.location) }
    }
    
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
}
