//
//  UploadingServiceType.swift
//  CrazyList
//
//  Created by Alex on 20/03/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import Foundation

protocol UploadingServiceType {
    
    typealias ProgressHandler = ((_ progress: Double) -> Void)
    
    func uploadDefaultDreams(defaultMyCollection: DefaultMyCollection, progressHandler: @escaping ProgressHandler, completion: @escaping (() -> Void))
}
