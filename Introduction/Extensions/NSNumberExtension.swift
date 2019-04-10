//
//  NSNumberExtension.swift
//  CrazyList
//
//  Created by Alex on 20/03/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import Foundation

extension NSNumber {
    
    func currencyString(priceLocal: Locale, style: NumberFormatter.Style = .currency) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.locale = priceLocal
        
        return formatter.string(from: self)
    }
}
