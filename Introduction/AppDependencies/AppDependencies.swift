//
//  AppDependencies.swift
//  CrazyList
//
//  Created by Alex on 19/01/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import CoreData
import UserNotifications


class AppDependencies: AppDependenciesType {
    
    // MARK: - Properties
    let container: Container
    
    // MARK: - Init
    init(container: Container = Container()) {
        self.container = container
        // Fix bug: https://github.com/Swinject/Swinject/issues/218
        Container.loggingFunction = nil
        
        configureAppDependencies()
    }
    
    // MARK: - Window factory methods
    func configureAppDelegate(_ appDelegate: AppDelegate) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        let storyboard = SwinjectStoryboard.create(name: "Introduction", bundle: nil, container: container)
        let rootViewController = storyboard.instantiateInitialViewController()
        window.rootViewController = rootViewController
        
        appDelegate.window = window
    }
    
    // MARK: - Configuration dependecies
    private func configureAppDependencies() {
        // 1
        configureCommonDependencies()
        // 2
        configureIntroductionModule(for: container)
    }
    
    private func configureCommonDependencies() {
        container.register(NSManagedObjectContext.self, name: Names.viewContext) { _ in CoreDataStack.shared.viewContext }
        container.register(NSManagedObjectContext.self, name: Names.backgroundContext) { _ in CoreDataStack.shared.backgroundContext }
        container.register(Dispatcher.self) { _ in Dispatcher.shared }
        container.register(UploadingService.self) { r in
            return UploadingService(dispatcher: r.resolve(Dispatcher.self)!, backgroundContext: r.resolve(NSManagedObjectContext.self, name: Names.backgroundContext)!)
        }
    }
    
    // MARK: - Names
    enum Names {
        static let viewContext = "viewContext"
        static let backgroundContext = "backgroundContext"
        static let freeDefaultDreams = "freeDefaultDreams"
    }
}

// MARk: - IntroductionModuleConfigurator
extension AppDependencies: IntroductionModuleConfigurator { }
