//
//  IntroductionIntroductionPresenterTests.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import XCTest
@testable import Introduction

class IntroductionPresenterTest: XCTestCase, TestObserver {

    var sut: IntroductionPresenter!
    var mockViewController: MockViewController!
    var mockInteractor: MockInteractor!
    var mockRouter: MockRouter!
    
    override func setUp() {
        super.setUp()
        sut = IntroductionPresenter()
        mockViewController = MockViewController(testObserver: self)
        mockInteractor = MockInteractor(testObserver: self)
        mockRouter = MockRouter(testObserver: self)
        
        sut.view = mockViewController
        sut.interactor = mockInteractor
        sut.router = mockRouter
    }

    override func tearDown() {
        sut = nil
        mockViewController = nil
        mockInteractor = nil
        
        super.tearDown()
    }
    
    // MARK: - TestObserver
    var log = ""
    
    // MARK: - IntroductionViewOutput
    func testViewIsReady() {
        // when
        sut.viewIsReady()
        // then
        XCTAssertEqual(log, "setupInitialState;")
    }
    
    func testViewIsAppered() {
        // when
        sut.viewIsAppeared()
        // then
        XCTAssertEqual(log, "obtainUploadingResultStatus;")
    }
    
    // MARK: - IntroductionInteractorOutput
    func testDidObtainUploadingResultStatusWithStatusTrue() {
        // given
        let mockDispatcher = MockDispatcher(testObserver: self)
        sut.dispatcher = mockDispatcher
        // when
        sut.didObtainUploadingResultStatus(true)
        // then
        XCTAssertEqual(log, "asyncMainQueue;openMyCollectionModule;")
        XCTAssertEqual(mockDispatcher.delay, 2)
    }
    
    func testDidObtainUploadingResultStatusWithStatusFalse() {
        // when
        sut.didObtainUploadingResultStatus(false)
        // then
        XCTAssertEqual(log, "uploadDefaultDreams;")
    }
    
    func testDidUpload() {
        // when
        sut.didUpload()
        // then
        XCTAssertEqual(log, "saveResultStatusOfUploading;openMyCollectionModule;")
        XCTAssertTrue(mockInteractor.resultStatusOfUploading)
    }
}

// MARK: - MockViewController
extension IntroductionPresenterTest {
    
    class MockViewController: IntroductionViewInput {
        
        // MARK: - TestObserver
        weak var testObserver: TestObserver!
        
        // MARK: - Init
        init(testObserver: TestObserver) {
            self.testObserver = testObserver
        }
        
        // MARK: - Test data
        var progressLoadingDescription = ""
        
        // MARK: - IntroductionViewInput
        func setupInitialState() {
            testObserver.log += "setupInitialState;"
        }
    }
}

// MARK: - MockInteractor
extension IntroductionPresenterTest {
    
    class MockInteractor: IntroductionInteractorInput {
        
        // MARK: - TestObserver
        weak var testObserver: TestObserver!
        
        // MARK: - Init
        init(testObserver: TestObserver) {
            self.testObserver = testObserver
        }
        
        // MARK: - Received data
        var resultStatusOfUploading = false
        
        // MARK: - IntroductionInteractorInput
        func obtainUploadingResultStatus() {
            testObserver.log += "obtainUploadingResultStatus;"
        }
        
        func uploadDefaultDreams() {
            testObserver.log += "uploadDefaultDreams;"
        }
        
        func saveResultStatusOfUploading(_ result: Bool) {
            resultStatusOfUploading = result
            testObserver.log += "saveResultStatusOfUploading;"
        }
    }
}

// MARK: - MockRouter
extension IntroductionPresenterTest {
    
    class MockRouter: IntroductionRouterInput {
        
        // MARK: - TestObserver
        weak var testObserver: TestObserver!
        
        // MARK: - Init
        init(testObserver: TestObserver) {
            self.testObserver = testObserver
        }
        
        // MARK: - IntroductionRouterInput
        func openMyCollectionModule() {
            testObserver.log += "openMyCollectionModule;"
        }
    }
}
