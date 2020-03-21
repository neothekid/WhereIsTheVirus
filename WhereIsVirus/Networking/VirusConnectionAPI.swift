//
//  VirusConnectionAPI.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation
import Moya

class VirusConnectionAPI {
    static let shared = VirusConnectionAPI()
    
    private init() {}
    
    func getEvents(completion: @escaping (Result<Events, Error>) -> Void) {
        fireRequest(.events, type: Events.self, completion: completion)
    }
}

extension VirusConnectionAPI {
    private func fireRequest<T: Decodable>(_ target: VirusTarget, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let provider = MoyaProvider<VirusTarget>()
        
        provider.request(target) {
            switch $0 {
            case .failure(let error): completion(.failure(error))
            case .success(let response):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.virusStrategy
                do {
                    completion(.success(try response.map(T.self, atKeyPath: nil, using: decoder, failsOnEmptyData: true)))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
