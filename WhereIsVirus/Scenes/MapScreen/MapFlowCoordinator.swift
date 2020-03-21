//
//  MapFlowCoordinator.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import XCoordinator

enum MapFlow: Route {
    case landing, dismiss
}

class MapFlowCoordinator: NavigationCoordinator<MapFlow> {
    init() {
        super.init(initialRoute: .landing)
        rootViewController.modalPresentationStyle = .fullScreen
    }
    
    override func prepareTransition(for route: MapFlow) -> NavigationTransition {
        switch route {
        case .landing:
            guard let vc: MapScreenViewController = UIStoryboard.instantiate(from: "Map") else {
                return .dismiss()
            }
            
            let vm = MapScreenViewModel(router: unownedRouter)
            vc.viewModel = vm
            return .push(vc)
        case .dismiss:
            return .dismiss(animation: .navigation)
        }
    }
}
