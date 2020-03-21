//
//  RootFlowCoordinator.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import XCoordinator

enum RootFlow: Route {
    case landing, map
}

class RootFlowCoordinator: NavigationCoordinator<RootFlow> {
    init() {
        super.init(initialRoute: .landing)
    }
    
    override func prepareTransition(for route: RootFlow) -> NavigationTransition {
        switch route {
        case .landing:
            guard let vc: LandingViewController = UIStoryboard.instantiate(from: "Landing") else {
                return .dismiss()
            }
            
            let vm = LandingViewModel(router: unownedRouter)
            vc.viewModel = vm
            return .push(vc)
        case .map:
            let coordinator = MapFlowCoordinator()
            return .present(coordinator, animation: .navigation)
        }
    }
}
