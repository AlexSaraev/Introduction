//
//  MyCollection.swift
//  CrazyList
//
//  Created by Alex on 13/10/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//

import Foundation
import CoreData

class MyCollection: NSManagedObject {
    
    // MARK: - Properties
    @NSManaged var lists: [List]!
    
    static var notificationCenter = NotificationCenter.default
    
    // MARK: - Create or get MyCollection static method
    static func createOrGetMyCollection(context: NSManagedObjectContext) -> MyCollection {
        let request = NSFetchRequest<MyCollection>(entityName: "MyCollection")
        
        if let myCollection = (try? context.fetch(request))?.first {
            return myCollection
        } else {
            let myCollection = MyCollection(context: context)
            context.save(descriptionOfChanges: "Creation the myCollection")
            return myCollection
        }
    }
    
    // MARK: - List interactions
    func addList(_ list: List) {
        let lists = self.mutableOrderedSetValue(forKey: "lists")
        
        guard !lists.contains(list) else {
            assertionFailure("MyCollection has already contained the such list.")
            return
        }
        lists.add(list)
        context?.save(descriptionOfChanges: "Adding a list")
        
        MyCollection.notificationCenter.post(name: NotificationNames.addingList, object: nil, userInfo: [MyCollection.NotificationKeys.listKey: list])
    }
    
    func swapList(_ list1: List, to list2: List) {
        let lists = self.mutableOrderedSetValue(forKey: "lists")
        
        guard lists.contains(list1) && lists.contains(list2) else {
            assertionFailure("The myCollection should contain the lists")
            return
        }
        
        let firstIndex = lists.index(of: list1)
        let secondIndex = lists.index(of: list2)
        
        lists.exchangeObject(at: firstIndex, withObjectAt: secondIndex)
        
        context?.save(descriptionOfChanges: "Exchange lists in the myCollection")
        
        MyCollection.notificationCenter.post(name: NotificationNames.swappingLists, object: nil, userInfo: [MyCollection.NotificationKeys.myCollectionKey: self])
    }
    
    // MARK: - Notications Names and Keys
    struct NotificationNames {
        static let addingList = Notification.Name("AddingList")
        static let swappingLists = Notification.Name("SwappingLists")
    }
    
    struct NotificationKeys {
        /// The key for getting the myCollection from a dictionary of Notification
        static let myCollectionKey = "MyCollectionKey"
        /// The key for getting a list from a dictionary of Notification
        static let listKey = "ListKey"
    }
    
}
