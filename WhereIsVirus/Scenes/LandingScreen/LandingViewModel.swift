//
//  LandingViewModel.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import XCoordinator

class LandingViewModel {
    private let router: UnownedRouter<RootFlow>
    
    init(router: UnownedRouter<RootFlow>) {
        self.router = router
    }
    
    func routeToMap() {
        router.trigger(.map)
    }
}
