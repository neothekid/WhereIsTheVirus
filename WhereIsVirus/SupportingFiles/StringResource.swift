//
//  StringResource.swift
//  WhereIsVirus
//
//  Created by maciej.burdzicki on 20/03/2020.
//  Copyright © 2020 maciej.burdzicki. All rights reserved.
//

import Foundation

enum StringResource: String {
    case letsStartTitle, signInTitle, mapTitle, virusTestLabel, positive, negative, reportVirus, stopVirus
}

extension StringResource {
    var value: String {
        var langCode = Locale.current.languageCode
        if let code = langCode, code == "pl" {
            langCode = "pl-PL"
        } else {
            langCode = "en"
        }
        
        guard let bundlePath = Bundle.main.path(forResource: langCode!, ofType: "lproj") else {
            return NSLocalizedString(rawValue, comment: "")
        }
        let bundle = Bundle(path: bundlePath)!
        return NSLocalizedString(rawValue, bundle: bundle, comment: "")
    }
}
