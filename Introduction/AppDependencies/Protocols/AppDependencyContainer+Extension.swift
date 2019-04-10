//
//  AppDependencyContainer.swift
//  CrazyList
//
//  Created by Alex on 21/01/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import Foundation
import Swinject

protocol AppDependencyContainer { }

extension AppDependencyContainer {
    
    var container: Container {
        return (UIApplication.shared.delegate as? AppDelegate)!.appDependencies.container
    }
}
