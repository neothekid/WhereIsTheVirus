//
//  LandingViewController.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import UIKit

class LandingViewController: UIViewController {
    @IBOutlet weak var virusTitle: UILabel!
    @IBOutlet weak var virusDescription: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    
    var viewModel: LandingViewModel!
    
    @IBAction func hdTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupView() {
        virusTitle.text = StringResource.mapTitle.value
        let button = VirusButtonView.initFromNib()
        button?.embedd(in: buttonContainer)
        button?.configure(style: .blue, title: StringResource.stopVirus.value, icon: nil) {
            self.viewModel.routeToMap()
        }
    }
}
