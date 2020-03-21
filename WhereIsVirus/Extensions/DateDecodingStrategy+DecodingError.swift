//
//  DateDecodingStrategy+DecodingError.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation

enum DecodingError: Error {
    case dateParsingFailure
}

extension JSONDecoder.DateDecodingStrategy {
    static var virusStrategy: JSONDecoder.DateDecodingStrategy {
        return JSONDecoder.DateDecodingStrategy.custom({ decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            throw DecodingError.dateParsingFailure
        })
    }
}
