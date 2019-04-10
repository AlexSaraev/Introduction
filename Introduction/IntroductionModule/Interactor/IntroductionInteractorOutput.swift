//
//  IntroductionIntroductionInteractorOutput.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation

protocol IntroductionInteractorOutput: class {
    
    func didObtainUploadingResultStatus(_ result: Bool)
    func didUpload()
}
