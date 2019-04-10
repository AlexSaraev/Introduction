//
//  MockViewController.swift
//  DostigatorTests
//
//  Created by Alex on 05/01/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import UIKit

class MockTransitionViewController: UIViewController {
    
    // MARK: - Counters
    var presentViewControllerCallCount = 0
    var dismissCallCount = 0
    
    // MARK: - Test properties
    var viewControllerToPresent: UIViewController!
    
    // MARK: - Overriden method
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentViewControllerCallCount += 1
        self.viewControllerToPresent = viewControllerToPresent
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCallCount += 1
    }
}
