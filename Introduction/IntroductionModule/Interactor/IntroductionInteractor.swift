//
//  IntroductionIntroductionInteractor.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//
import Foundation

class IntroductionInteractor {
    
    // MARK: - Properties
    weak var output: IntroductionInteractorOutput!
    var userDefaults: UserDefaults!
    var uploadingService: UploadingServiceType!
    var freeDefaultMyCollection: DefaultMyCollection!
    
    private enum Keys {
        static let uploadingResultStatus = "UploadingResultStatus"
    }
}

// MARK: - IntroductionInteractorInput
extension IntroductionInteractor: IntroductionInteractorInput {
    
    func obtainUploadingResultStatus() {
        output.didObtainUploadingResultStatus(userDefaults.bool(forKey: Keys.uploadingResultStatus))
    }
    
    func uploadDefaultDreams() {
        uploadingService.uploadDefaultDreams(defaultMyCollection: freeDefaultMyCollection, progressHandler: { _ in }, completion: { [weak self] in
            self?.output.didUpload()
        })
    }
    
    func saveResultStatusOfUploading(_ result: Bool) {
        userDefaults.set(result, forKey: Keys.uploadingResultStatus)
    }
}
