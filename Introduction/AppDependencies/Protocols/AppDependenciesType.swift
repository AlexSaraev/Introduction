//
//  AppDependenciesType.swift
//  CrazyList
//
//  Created by Alex on 27/02/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import Foundation
import Swinject

protocol AppDependenciesType {
    
    var container: Container { get }
    
    func configureAppDelegate(_ appDelegate: AppDelegate)
}
