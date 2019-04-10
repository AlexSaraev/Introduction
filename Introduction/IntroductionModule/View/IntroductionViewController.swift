//
//  IntroductionIntroductionViewController.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Lottie

class IntroductionViewController: UIViewController {
    
    // MARK: - Properties
    var output: IntroductionViewOutput!
    
    // MARK: - Outlets
    @IBOutlet weak var flowViewAnimation: LOTAnimationView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewIsAppeared()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - IntroductionViewInput
extension IntroductionViewController: IntroductionViewInput {
    
    func setupInitialState() {
        flowViewAnimation.loopAnimation = true
        flowViewAnimation.setAnimation(named: "Flow")
        flowViewAnimation.play()
    }
    
}
