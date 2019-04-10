//
//  IntroductionIntroductionViewTests.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import XCTest
import Lottie
@testable import Introduction

class IntroductionViewTests: XCTestCase, TestObserver {
    
    var sut: IntroductionViewController!
    var mockFlowViewAnimation: MockFlowViewAnimation!
    var mockPresenter: MockPresenter!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Introduction", bundle: nil)
        sut = storyboard.instantiateInitialViewController() as? IntroductionViewController
        
        mockPresenter = MockPresenter(testObserver: self)
        
        sut.output = mockPresenter
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        mockFlowViewAnimation = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    // MARK: - TestObserver
    var log = ""
    
    // MARK: - Creating methods
    func createAndSetMockViewAnimation() -> MockFlowViewAnimation {
        let mockFlowViewAnimation = MockFlowViewAnimation()
        mockFlowViewAnimation.testObserver = self
        sut.flowViewAnimation = mockFlowViewAnimation
        return mockFlowViewAnimation
    }
    
    // MARK: - Life cycle
    func testViewDidLoadCallsViewIsReady() {
        XCTAssertEqual("viewIsReady;", log)
    }
    
    func testViewDidAppearCallsViewIsAppeared() {
        // when
        sut.viewDidAppear(true)
        // then
        XCTAssertEqual("viewIsReady;viewIsAppeared;", log)
    }
    
    func testPreferredStatusBarStyleIsLightContent() {
        XCTAssertEqual(UIStatusBarStyle.lightContent, sut.preferredStatusBarStyle)
    }
    
    // MARK: - IntroductionViewInput
    func testSetupInitialState() {
        // given
        let mockFlowViewAnimation = createAndSetMockViewAnimation()
        // when
        sut.setupInitialState()
        // then
        XCTAssertTrue(mockFlowViewAnimation.loopAnimation)
        XCTAssertEqual("viewIsReady;setAnimation;", log)
        XCTAssertEqual("Flow", mockFlowViewAnimation.named)
        XCTAssertTrue(mockFlowViewAnimation.isAnimationPlaying)
    }
    
}

// MARK: - MockPresenter
extension IntroductionViewTests {
    
    class MockPresenter: IntroductionViewOutput {
        
        // MARK: - TestObserver
        weak var testObserver: TestObserver!
        
        // MARK: - Init
        init(testObserver: TestObserver) {
            self.testObserver = testObserver
        }
        
        // MARK: - IntroductionViewOutput
        func viewIsReady() {
            testObserver.log += "viewIsReady;"
        }
        
        func viewIsAppeared() {
            testObserver.log += "viewIsAppeared;"
        }
    }
}

// MARK: - MockViewAnimation
extension IntroductionViewTests {
    
    class MockFlowViewAnimation: LOTAnimationView {
        
        // MARK: - TestObserver
        weak var testObserver: TestObserver!
        
        // MARK: - Test data
        var named = ""
        
        // MARK: - Public methods
        override func setAnimation(named: String) {
            testObserver.log += "setAnimation;"
            self.named = named
            super.setAnimation(named: named)
        }
    }
}
