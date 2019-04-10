//
//  List.swift
//  CrazyList
//
//  Created by Alex on 13/10/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//

import Foundation
import CoreData

class List: NSManagedObject {
    
    // MARK: - Properties
    @NSManaged var id: String
    @NSManaged var title: String
    @NSManaged var myCollection: MyCollection?
    @NSManaged var dreams: [Dream]!
    
    static var notificationCenter = NotificationCenter.default
    
    // MARK: - Static methods of creating list
    static func сreateList(withTitle title: String, context: NSManagedObjectContext) -> List {
        let list = List(context: context)
        list.id = "user\(Date().timeIntervalSinceReferenceDate)"
        list.title = title
        
        context.save(descriptionOfChanges: "Creation new List")
        
        return list
    }
    
    static func createOrGetListWith(id: String, title: String, context: NSManagedObjectContext) -> List {
        let request = NSFetchRequest<List>(entityName: "List")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        if let list = (try? context.fetch(request))?.first {
            return list
        } else {
            let list = List(context: context)
            list.id = id
            list.title = title
            
            context.save(descriptionOfChanges: "Creation the List with the id")
            
            return list
        }
    }
    
    // MARK: - Swapping dreams
    func swapDream(_ dream1: Dream, to dream2: Dream) {
        let dreams = self.mutableOrderedSetValue(forKey: "dreams")
        
        guard dreams.contains(dream1) && dreams.contains(dream2) else {
            assertionFailure("The list should contains the dreams")
            return
        }
        
        let firstIndex = dreams.index(of: dream1)
        let secondIndex = dreams.index(of: dream2)
        
        dreams.exchangeObject(at: firstIndex, withObjectAt: secondIndex)
        
        context?.save(descriptionOfChanges: "Exchange dreams in the list")
        
        List.notificationCenter.post(name: NotificationNames.swappingDreams, object: nil, userInfo: [NotificationKeys.listKey: self])
    }
    
    // MARK: - Save and remove list methods
    func save() {
        context?.save(descriptionOfChanges: "Changing the list")
        
        List.notificationCenter.post(name: NotificationNames.changingList, object: nil, userInfo: [NotificationKeys.listKey: self])
    }
    
    func remove() {
        context?.delete(self)
        context?.save(descriptionOfChanges: "Deleting the list")
        
        List.notificationCenter.post(name: NotificationNames.deletingList, object: nil, userInfo: [NotificationKeys.listKey: self])
    }
    
    // MARK: - Dream interactions
    func insert(_ dream: Dream, at index: Int) {
        let dreams = self.mutableOrderedSetValue(forKey: "dreams")
        
        guard !dreams.contains(dream) else {
            assertionFailure("The list has already contained the such dream.")
            return
        }
        dreams.insert(dream, at: index)
        context?.save(descriptionOfChanges: "Adding a dream to the list")
        
        List.notificationCenter.post(name: NotificationNames.addingDream, object: nil, userInfo: [NotificationKeys.dreamKey: dream, NotificationKeys.listKey: self])
    }
    
    func addDream(_ dream: Dream) {
        let dreams = self.mutableOrderedSetValue(forKey: "dreams")
        
        guard !dreams.contains(dream) else {
            assertionFailure("The list has already contained the such dream.")
            return
        }
        dreams.add(dream)
        context?.save(descriptionOfChanges: "Adding a dream")
        
        List.notificationCenter.post(name: NotificationNames.addingDream, object: nil, userInfo: [NotificationKeys.dreamKey: dream, NotificationKeys.listKey: self])
    }
    
    func removeFromList(_ dream: Dream) {
        let dreams = self.mutableOrderedSetValue(forKey: "dreams")
        dreams.remove(dream)
        
        self.context?.save(descriptionOfChanges: "Deleting Dream from list")
        
        List.notificationCenter.post(name: NotificationNames.deletingDreamFromList, object: nil, userInfo: [NotificationKeys.dreamKey: dream, NotificationKeys.listKey: self])
    }
    
    // MARK: - Notications Names and Keys
    struct NotificationNames {
        static let changingList = Notification.Name("ChangingList")
        static let deletingList = Notification.Name("DeletingList")
        static let addingDream = Notification.Name("AddingDream")
        static let swappingDreams = Notification.Name("SwappingDreams")
        static let deletingDreamFromList = Notification.Name("DeletingDreamFromList")
    }
    
    struct NotificationKeys {
        /// The key for getting a dream from a dictionary of Notification
        static let listKey = "ListKey"
        /// The key for getting a list from a dictionary of Notification
        static let dreamKey = "DreamKey"
    }
}
