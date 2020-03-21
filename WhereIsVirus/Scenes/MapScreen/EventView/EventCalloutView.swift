//
//  EventCalloutView.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 21/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import UIKit
import MapKit

class EventCalloutView: UIView {
    @IBOutlet weak var badgeView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var virusTestLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var isConfirmed: Bool = false {
        didSet {
            badgeView.isHidden = !isConfirmed
            let color = isConfirmed ? UIColor(red: 1, green: 0.1765, blue: 0.3333, alpha: 1) : UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)
            virusTestLabel.textColor = color
            resultLabel.textColor = color
            resultLabel.text = isConfirmed ? StringResource.positive.value.uppercased() : StringResource.negative.value.uppercased()
        }
    }
    
    var annotation: EventLocation? {
        didSet {
            isConfirmed = annotation?.model.confirmedBySanepid ?? false
            descriptionLabel.text = annotation?.model.description
            
            guard let coords = annotation?.coordinate else {
                locationLabel.text = "-"
                return
            }
            
            LocationManager.shared.getPlace(for: CLLocation(latitude: coords.latitude, longitude: coords.longitude)) { [weak self] in
                guard let placemark = $0 else {
                    self?.locationLabel.text = "-"
                    return
                }
                
                var string = ""
                if let addressOne = placemark.thoroughfare, let addressTwo = placemark.subThoroughfare {
                    string = "\(addressOne) \(addressTwo)"
                }
                
                if let city = placemark.locality {
                    string = string != "" ? "\(string), \(city)" : city
                }
                
                if string == "" {
                    string = "-"
                }
                
                self?.locationLabel.text = string
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        virusTestLabel.text = StringResource.virusTestLabel.value
        resultLabel.text = isConfirmed ? StringResource.positive.value.uppercased() : StringResource.negative.value.uppercased()
    }
}
