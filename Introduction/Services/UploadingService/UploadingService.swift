//
//  UploadingService.swift
//  CrazyList
//
//  Created by Alex on 20/03/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import CoreData
import UIKit

class UploadingService: UploadingServiceType {
    
    // MARK: - Properties
    private let backgroundContext: NSManagedObjectContext
    private let dispatcher: DispatcherType!
    
    private var completion: (() -> Void)?
    private var progressHandler: ProgressHandler?
    private var progress: Double {
        return Double(totalUploaded) / Double(defaultMyCollection.totalItems)
    }
    private var defaultMyCollection: DefaultMyCollection!
    private var totalUploaded: Int = 0 { didSet { updateProgress() }}
    
    // MARK: - Init
    init(dispatcher: DispatcherType, backgroundContext: NSManagedObjectContext) {
        self.dispatcher = dispatcher
        self.backgroundContext = backgroundContext
    }
    
    // MARK: - IntroductionUploadingServiceType
    func uploadDefaultDreams(defaultMyCollection: DefaultMyCollection, progressHandler: @escaping ProgressHandler, completion: @escaping () -> Void) {
        // 1
        self.defaultMyCollection = defaultMyCollection
        self.completion = completion
        self.progressHandler = progressHandler
        // 2
        self.totalUploaded = 0
        
        dispatcher.asyncGlobalQueue(qos: .userInitiated) { [unowned self] in
            self.upload()
        }
    }
    
    // MARK: - Private methods
    private func upload() {
        backgroundContext.performAndWait { [unowned self] in
            let myCollection = MyCollection.createOrGetMyCollection(context: self.backgroundContext)
            
            for defaultList in self.defaultMyCollection.defaultLists {
                let list = List.createOrGetListWith(id: defaultList.id, title: defaultList.title, context: self.backgroundContext)
                self.addListIfNeeded(list, to: myCollection)
                
                for defaultDream in defaultList.defaultDreams {
                    let dream = Dream.createOrGetDreamWith(with: defaultDream, context: self.backgroundContext)
                    self.addDreamIfNeeded(dream, to: list)
                    
                    self.totalUploaded += 1
                }
            }
        }
    }
    
    private func addListIfNeeded(_ list: List, to myCollection: MyCollection) {
        if list.myCollection == nil {
            myCollection.addList(list)
        }
    }
    
    private func addDreamIfNeeded(_ dream: Dream, to list: List) {
        if dream.list == nil {
            list.addDream(dream)
        }
    }
    
    private func updateProgress() {
        dispatcher.asyncMainQueue(delay: 0) { [unowned self] in
            self.progressHandler?(self.progress)
            
            if self.progress >= 1 {
                self.completion?()
            }
        }
    }
    
}
