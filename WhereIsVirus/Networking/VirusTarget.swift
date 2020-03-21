//
//  VirusTarget.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import Moya

enum VirusTarget {
    case events
}

extension VirusTarget: TargetType {
    var baseURL: URL { URL(string: "http://40.127.161.48:8080/api/")! }
    
    var path: String {
        switch self {
        case .events:
            return "events"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .events:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var sampleData: Data { Data() }
}
