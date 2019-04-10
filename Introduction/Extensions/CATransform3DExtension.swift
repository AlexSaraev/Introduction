//
//  CATransform3DExtension.swift
//  CrazyList
//
//  Created by Alex on 22/11/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//

import UIKit

extension CATransform3D {
    
    func perspective() -> CATransform3D {
        var transform = self
        transform.m34 = -0.002
        return transform
    }
}
