//
//  DefaultDream.swift
//  CrazyList
//
//  Created by Alex on 02/02/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import Foundation

// Model for default content from JSON.
struct DefaultDream: Decodable {
    
    // MARK: - Properties
    let id: String
    let target: String
    let literalPictureName: String
    
    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        self.id = try decoder.container(keyedBy: Keys.self).decode(String.self, forKey: .id)
        self.target = try decoder.container(keyedBy: Keys.self).decode(String.self, forKey: Localization.current == .ru ? .targetRU : .targetEN)
        self.literalPictureName = try decoder.container(keyedBy: Keys.self).decode(String.self, forKey: .literalPictureName)
    }
        
    // MARK: - Keys
    enum Keys: CodingKey {
        case id
        case targetEN
        case targetRU
        case literalPictureName
    }
}
