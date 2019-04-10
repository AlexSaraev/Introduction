//
//  IntroductionIntroductionRouter.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//
import UIKit
import Swinject
import SwinjectStoryboard

class IntroductionRouter: AppDependencyContainer {
    
    // MARK: - Properties
    weak var transitionViewController: UIViewController!
    
}

// MARK: - IntroductionRouterInput
extension IntroductionRouter: IntroductionRouterInput {
    
    func openMyCollectionModule() {
        let storybaord = SwinjectStoryboard.create(name: "MyCollection", bundle: nil, container: container)
        let myCollectionViewController = storybaord.instantiateInitialViewController()
        myCollectionViewController?.modalTransitionStyle = .crossDissolve

        transitionViewController.present(myCollectionViewController!, animated: true)
    }
}
