//
//  Extensions.swift
//  CrazyList
//
//  Created by Alex on 20/07/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//

import Foundation

extension String {
    
    var hasWhiteSpacesOnly: Bool {
        let whitespace = CharacterSet.whitespacesAndNewlines
        let trimmed = self.trimmingCharacters(in: whitespace)
        if trimmed.count == 0 {
            return true
        } else {
            return false
        }
    }
}
