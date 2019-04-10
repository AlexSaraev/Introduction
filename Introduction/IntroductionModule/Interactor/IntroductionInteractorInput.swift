//
//  IntroductionIntroductionInteractorInput.swift
//  CrazyList
//
//  Created by Alex Saraev on 29/01/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation

protocol IntroductionInteractorInput {
    
    func obtainUploadingResultStatus()
    func uploadDefaultDreams()
    func saveResultStatusOfUploading(_ result: Bool)
}
