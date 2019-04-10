//
//  Localization.swift
//  CrazyList
//
//  Created by Alex on 04/02/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import Foundation

/// Localization of the app.
enum Localization: String {
    
    // MARK: - Static properties
    static private (set) var current: Localization = {
        if let languageCode = Locale.current.languageCode,
            let localization = Localization(rawValue: languageCode) {
            return localization
        } else {
            return Localization.en
        }
    }()
    
    // MARK: - Static methods
    static func setCurrentLocalization(_ localization: Localization) {
        current = localization
    }
    
    // MARK: - Cases
    case en
    case ru
}
