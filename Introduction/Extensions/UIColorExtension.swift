//
//  UIColorExtension.swift
//  CrazyList
//
//  Created by Alex on 04/10/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init?(hexValue rawHexValue: String, alpha: CGFloat) {
        guard rawHexValue.count == 6 || rawHexValue.count == 7 else { return nil }
        
        var hexValue: UInt32 = 0
        let scanner = Scanner(string: rawHexValue)
        
        if rawHexValue.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        scanner.scanHexInt32(&hexValue)
        
        let redColorValue = CGFloat((hexValue & 0xFF0000) >> 16)
        let greenColorValue = CGFloat((hexValue & 0x00FF00) >> 8)
        let blueColorValue = CGFloat((hexValue & 0x0000FF))
        
        self.init(red: redColorValue / 255, green: greenColorValue / 255, blue: blueColorValue / 255, alpha: alpha)
    }
}
