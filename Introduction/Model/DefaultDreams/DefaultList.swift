//
//  DefaultList.swift
//  CrazyList
//
//  Created by Alex on 01/02/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import Foundation

// Model for default content from JSON.
struct DefaultList: Decodable {
    
    // MARK: - Property
    let id: String
    let title: String
    let defaultDreams: [DefaultDream]
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        self.id = try decoder.container(keyedBy: Keys.self).decode(String.self, forKey: .id)
        self.title = try decoder.container(keyedBy: Keys.self).decode(String.self, forKey: Localization.current == .ru ? .titleRU : .titleEN)
        self.defaultDreams = try decoder.container(keyedBy: Keys.self).decode([DefaultDream].self, forKey: .defaultDreams)
    }
    
    // MARK: - Keys
    enum Keys: CodingKey {
        case id
        case titleEN
        case titleRU
        case defaultDreams
    }
}
