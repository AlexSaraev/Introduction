//
//  IntroductionIntroductionPresenter.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

class IntroductionPresenter {
    
    // MARK: - Properties
    weak var view: IntroductionViewInput!
    var interactor: IntroductionInteractorInput!
    var router: IntroductionRouterInput!
    var dispatcher: DispatcherType!

}

// MARK: - IntroductionViewOutput
extension IntroductionPresenter: IntroductionViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func viewIsAppeared() {
        interactor.obtainUploadingResultStatus()
    }
}

// MARK: - IntroductionInteractorOutput
extension IntroductionPresenter: IntroductionInteractorOutput {
    
    func didObtainUploadingResultStatus(_ result: Bool) {
        if result {
            dispatcher.asyncMainQueue(delay: 2) { [weak self] in
                self?.router.openMyCollectionModule()
            }
        } else {
            interactor.uploadDefaultDreams()
        }
    }
    
    func didUpload() {
        interactor.saveResultStatusOfUploading(true)
        router.openMyCollectionModule()
    }
    
}
