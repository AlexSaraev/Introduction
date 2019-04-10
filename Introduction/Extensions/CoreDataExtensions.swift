//
//  CoreDataExtensions.swift
//  CrazyList
//
//  Created by Alex on 07/09/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func save(descriptionOfChanges description: String) {
        do {
            try save()
            print("\(description) has been saved successfully")
        } catch {
            assertionFailure("Save error \(description): \(error.localizedDescription)")
        }
    }
    
    func fetchWithDoCatchBlock<T>(with request: NSFetchRequest<T>, requestDescription description: String) -> [T]? {
        do {
            let fetchedDreams = try fetch(request)
            return fetchedDreams
        } catch {
            assertionFailure("Fetch error \(description): \(error.localizedDescription)")
            return nil
        }
    }
    
    func countDreams<T>(with request: NSFetchRequest<T>, requestDescription description: String) -> Int {
        do {
            let countDreams = try count(for: request)
            return countDreams
        } catch {
            assertionFailure("Fetch counting error \(description): \(error.localizedDescription)")
            return 0
        }
    }
}

public extension NSManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
    
    var context: NSManagedObjectContext? {
        if let context = self.managedObjectContext {
            return context
        } else {
            assertionFailure("Unexpectedly it has been received nil in managedObjectContext.")
            return nil
        }
    }
}
