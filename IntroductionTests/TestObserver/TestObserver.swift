//
//  TestResult.swift
//  DostigatorTests
//
//  Created by Alex on 01/02/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import Foundation

protocol TestObserver: class {
    
    var log: String { get set }
}
