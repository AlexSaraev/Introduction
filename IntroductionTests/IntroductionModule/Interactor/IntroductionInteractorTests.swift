//
//  IntroductionIntroductionInteractorTests.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import XCTest
import CoreData
@testable import Introduction

class IntroductionInteractorTests: XCTestCase, TestObserver {

    var sut: IntroductionInteractor!
    var mockPresenter: MockPresenter!
    var fakeUserDefaults: FakeUsetDefaults!
    
    override func setUp() {
        super.setUp()
        sut = IntroductionInteractor()
        mockPresenter = MockPresenter(testObserver: self)
        fakeUserDefaults = FakeUsetDefaults()
        
        sut.output = mockPresenter
        sut.userDefaults = fakeUserDefaults
        sut.freeDefaultMyCollection = DefaultMyCollection(defaultLists: [], totalItems: 0)
    }

    override func tearDown() {
        sut = nil
        mockPresenter = nil
        fakeUserDefaults = nil
        log = ""
        
        super.tearDown()
    }
    
    // MARK: - TestListener
    var log = ""
    
    // MARK: - IntroductionInteractorInput
    func testObtainUploadingResultStatusCallsPresenterWithResultTrue() {
        // given
        fakeUserDefaults.set(true, forKey: "UploadingResultStatus")
        // when
        sut.obtainUploadingResultStatus()
        // then
        XCTAssertEqual("didObtainUploadingResultStatus;", log)
        XCTAssertEqual(true, mockPresenter.result)
    }
    
    func testObtainUploadingResultStatusCallsPresenterWithResultFalse() {
        // given
        fakeUserDefaults.set(false, forKey: "UploadingResultStatus")
        // when
        sut.obtainUploadingResultStatus()
        // then
        XCTAssertEqual("didObtainUploadingResultStatus;", log)
        XCTAssertEqual(false, mockPresenter.result)
    }
    
    func testUploadDefaultDreamsCalls() {
        // given
        let mockUploadingService = MockIntroductionUploadingService(testObserver: self)
        sut.uploadingService = mockUploadingService
        // when
        sut.uploadDefaultDreams()
        // then
        XCTAssertEqual("uploadDefaultDreams;didUpload;", log)
    }
    
    func testSaveResultStatusOfUploadingWithStatusTrue() {
        // when
        sut.saveResultStatusOfUploading(true)
        // then
        XCTAssertEqual(fakeUserDefaults.bool(forKey: "UploadingResultStatus"), true)
    }
    
    func testSaveResultStatusOfUploadingWithStatusFalse() {
        // when
        sut.saveResultStatusOfUploading(false)
        // then
        XCTAssertEqual(fakeUserDefaults.bool(forKey: "UploadingResultStatus"), false)
    }
    
}

// MARK: - MockPresenter
extension IntroductionInteractorTests {
    
    class MockPresenter: IntroductionInteractorOutput {
        
        // MARK: - TestObserver
        weak var testObserver: TestObserver!
        
        // MARK: - Recieved data
        var result: Bool!
        
        // MARK: - Init
        init(testObserver: TestObserver) {
            self.testObserver = testObserver
        }
        
        // MARK: - IntroductionInteractorOutput
        func didObtainUploadingResultStatus(_ result: Bool) {
            self.result = result
            testObserver.log += "didObtainUploadingResultStatus;"
        }
        
        func didUpload() {
            testObserver.log += "didUpload;"
        }
    }
}

// MARK: - MockUploadingService
extension IntroductionInteractorTests {
    
    class MockIntroductionUploadingService: UploadingServiceType {
        
        // MARK: - TestObserver
        weak var testObserver: TestObserver!
        
        // MARK: - Fake data
        var result: Bool!
        
        // MARK: - Init
        init(testObserver: TestObserver) {
            self.testObserver = testObserver
        }
        
        // MARK: - UploadingServiceType
        func uploadDefaultDreams(defaultMyCollection: DefaultMyCollection, progressHandler: @escaping ProgressHandler, completion: @escaping (() -> Void)) {
            testObserver.log += "uploadDefaultDreams;"
            progressHandler(25.0)
            completion()
        }
    }
}

// MARK: - FakeUsetDefaults
extension IntroductionInteractorTests {
    
    class FakeUsetDefaults: UserDefaults {
        
        var bool = false
        
        override func set(_ value: Bool, forKey defaultName: String) {
            if defaultName == "UploadingResultStatus" {
                bool = value
            }
        }
        
        override func bool(forKey defaultName: String) -> Bool {
            if defaultName == "UploadingResultStatus" {
                return bool
            } else {
                return false
            }
        }
    }
}
