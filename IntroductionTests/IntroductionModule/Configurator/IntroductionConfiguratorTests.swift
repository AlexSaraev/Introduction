//
//  IntroductionIntroductionConfiguratorTests.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import XCTest
import Swinject
import SwinjectStoryboard
@testable import Introduction

class IntroductionModuleConfiguratorTests: XCTestCase, AppDependencyContainer {

    func testRegisterIntroductionModule() {
        // given
        let sut = TestableIntroductionModuleConfigurator()
        
        // when
        sut.configureIntroductionModule(for: container)
        let storyboard = SwinjectStoryboard.create(name: "Introduction", bundle: nil, container: container)
        let viewController = storyboard.instantiateInitialViewController() as! IntroductionViewController
        
        // then
        XCTAssertNotNil(viewController.output, "IntroductionViewController is nil after configuration")
        XCTAssertTrue(viewController.output is IntroductionPresenter, "output is not IntroductionPresenter")
        
        let presenter: IntroductionPresenter = viewController.output as! IntroductionPresenter
        XCTAssertNotNil(presenter.view, "view in IntroductionPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in IntroductionPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is IntroductionRouter, "router is not IntroductionRouter")
        
        let interactor: IntroductionInteractor = presenter.interactor as! IntroductionInteractor
        XCTAssertNotNil(interactor.output, "output in IntroductionInteractor is nil after configuration")
        XCTAssertNotNil(interactor.uploadingService, "uploadingService in IntroductionInteractor is nil after configuration")
        XCTAssertNotNil(interactor.userDefaults, "uploadingService in IntroductionInteractor is nil after configuration")
        
        let router = presenter.router as! IntroductionRouter
        XCTAssertNotNil(router.transitionViewController, "transitionViewController in IntroductionRouter is nil after configuration")
        XCTAssertNotNil(router.container, "container in IntroductionRouter is nil after configuration")
        XCTAssertTrue(router.transitionViewController is IntroductionViewController, "transitionViewController is not IntroductionViewController")
    }

}

// MARK: - TestableIntroductionModuleConfigurator
extension IntroductionModuleConfiguratorTests {
    
    class TestableIntroductionModuleConfigurator: IntroductionModuleConfigurator { }
}
