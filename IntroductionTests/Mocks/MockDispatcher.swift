//
//  MockDispatcher.swift
//  DostigatorTests
//
//  Created by Alex on 05/02/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import UIKit
@testable import Introduction

class MockDispatcher: DispatcherType {
    
    // MARK: - TestObserver
    weak var testObserver: TestObserver!
    
    // MARK: - Init
    init(testObserver: TestObserver) {
        self.testObserver = testObserver
    }
    
    // MARK: - Recieved data
    var delay: Double = 0
    
    // MARK: - DispatcherType
    func asyncMainQueue(delay seconds: Double, execution: @escaping () -> Void) {
        testObserver.log += "asyncMainQueue;"
        delay = seconds
        execution()
    }
    
    func asyncGlobalQueue(qos: DispatchQoS.QoSClass, execution: @escaping () -> Void) {
        testObserver.log += "asyncGlobalQueue;"
        execution()
    }
    
    func resizeImageInBackgroundQueue(image: UIImage, toWidth width: CGFloat, completion: @escaping (_ image: UIImage) -> Void) {
        // do nothing
    }
}
