//
//  IntroductionIntroductionConfigurator.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import CoreData
import Swinject
import SwinjectStoryboard

protocol IntroductionModuleConfigurator {
    
    func configureIntroductionModule(for container: Container)
}

extension IntroductionModuleConfigurator {
    
    func configureIntroductionModule(for container: Container) {
        
        // Interactor
        // 1
        container.register(Data.self, name: AppDependencies.Names.freeDefaultDreams) { _ in
            let plistURL = Bundle.main.url(forResource: "FreeDefaultDreams", withExtension: "plist")
            let plistData = try? Data(contentsOf: plistURL!)
            return plistData!
        }
        // 2
        container.register(DefaultMyCollection.self, name: AppDependencies.Names.freeDefaultDreams) { r in
            let decoder = PropertyListDecoder()
            let plistData = r.resolve(Data.self, name: AppDependencies.Names.freeDefaultDreams)
            let defaultMyCollection = try? decoder.decode(DefaultMyCollection.self, from: plistData!)
            
            return defaultMyCollection!
        }
        container.register(UserDefaults.self) { _ in UserDefaults.standard }
        // 3
        container.register(IntroductionInteractor.self) { r in
            let interactor = IntroductionInteractor()
            interactor.userDefaults = r.resolve(UserDefaults.self)
            interactor.uploadingService = r.resolve(UploadingService.self)
            interactor.freeDefaultMyCollection = r.resolve(DefaultMyCollection.self, name: AppDependencies.Names.freeDefaultDreams)
            
            return interactor
        }
        
        // Router
        container.register(IntroductionRouter.self) { _ in IntroductionRouter() }
        
        // Presenter
        container.register(IntroductionPresenter.self) { r in
            let presenter = IntroductionPresenter()
            presenter.interactor = r.resolve(IntroductionInteractor.self)
            presenter.router = r.resolve(IntroductionRouter.self)
            presenter.dispatcher = r.resolve(Dispatcher.self)
            
            return presenter
        }
        
        // view
        container.storyboardInitCompleted(IntroductionViewController.self) { r, view in
            let router = r.resolve(IntroductionRouter.self)
            let presenter = r.resolve(IntroductionPresenter.self)
            let interactor = r.resolve(IntroductionInteractor.self)
            
            router?.transitionViewController = view
            presenter?.view = view
            interactor?.output = presenter
            view.output = presenter
        }
    }
}
