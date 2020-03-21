//
//  MapScreenViewController.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapScreenViewController: UIViewController {
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var navigationView: ViewWithGradient!
    @IBOutlet private weak var reportVirusContainer: VirusButtonView!
    
    var viewModel: MapScreenViewModel!
    
    @IBAction func backTapped(_ sender: Any) {
        viewModel.routeBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.unsubscribeForLocationUpdates()
    }
    
    private func setupView() {
        mapView.delegate = self
        mapView.register(UserPinView.self, forAnnotationViewWithReuseIdentifier: "UserPinView")
        mapView.register(EventView.self, forAnnotationViewWithReuseIdentifier: "EventView")
        navigationView.configure(gradientColors: [.systemBGColor, UIColor.systemBGColor.withAlphaComponent(0)],
                                 startPoint: CGPoint(x: 0.0, y: 0.65),
                                 endPoint: CGPoint(x: 0.0, y: 1.0)
        )
        titleLabel.text = StringResource.mapTitle.value
        centerMapOnLocation(LocationManager.shared.currentLocation)
        viewModel.didUpdateLocation = { [weak self] in
            self?.centerMapOnLocation($0)
        }
        viewModel.subscribeForLocationUpdates()
        viewModel.fetchEvents { [weak self] in
            $0.forEach { self?.addPin($0) }
        }
        
        let virusButtonView = VirusButtonView.initFromNib()
        virusButtonView?.embedd(in: reportVirusContainer)
        virusButtonView?.configure(style: .red, title: StringResource.reportVirus.value, icon: UIImage(named: "Report.pdf")) {
            print("TAP!")
        }
    }
}

extension MapScreenViewController {
    func centerMapOnLocation(_ location: CLLocation?) {
        guard let location = location else {
            return
        }
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        addPin(CurrentLocationAnnotaion(coordinate: location.coordinate))
    }
    
    func addPin(_ pin: MKAnnotation) {
        mapView.addAnnotation(pin)
    }
}

extension MapScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let point = annotation as? CurrentLocationAnnotaion {
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "UserPinView") as? UserPinView
            view?.annotation = point
            return view
        } else if let point = annotation as? EventLocation {
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "EventView", for: point) as? EventView
            view?.isConfirmed = point.model.confirmedBySanepid
            point.title = ""
            view?.canShowCallout = true
            view?.annotation = point
            return view
        }
        
        return MKAnnotationView()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {
            return
        }
        
        let detailView = EventCalloutView.initFromNib()
        detailView?.annotation = annotation as? EventLocation
        view.detailCalloutAccessoryView = detailView
        view.leftCalloutAccessoryView = nil
        view.rightCalloutAccessoryView = nil
        view.canShowCallout = true
    }
}
