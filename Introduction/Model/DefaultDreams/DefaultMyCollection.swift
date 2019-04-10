//
//  DefaultMyCollection.swift
//  CrazyList
//
//  Created by Alex on 02/02/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import Foundation

// Model for default content from JSON.
struct DefaultMyCollection: Decodable {
    
    let defaultLists: [DefaultList]
    let totalItems: Int
}
