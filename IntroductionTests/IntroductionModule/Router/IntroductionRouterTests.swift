//
//  IntroductionIntroductionRouterTests.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import XCTest
@testable import Introduction

class IntroductionRouterTests: XCTestCase {

    var sut: IntroductionRouter!
    var mockTransitionViewController: MockTransitionViewController!
    
    override func setUp() {
        super.setUp()
        sut = IntroductionRouter()
        mockTransitionViewController = MockTransitionViewController()
        
        sut.transitionViewController = mockTransitionViewController
    }

    override func tearDown() {
        sut = nil
        mockTransitionViewController = nil
        
        super.tearDown()
    }
    
    func testOpenMyCollectionModule() {
        // when
        sut.openMyCollectionModule()
        // then
        XCTAssertEqual(mockTransitionViewController.presentViewControllerCallCount, 1)
    }
}
