//
//  AppDelegate.swift
//  Introduction
//
//  Created by Alex on 10/04/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    var window: UIWindow?
    var appDependencies: AppDependenciesType = AppDependencies()
    
    // MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appDependencies.configureAppDelegate(self)
        return true
    }
    
}

