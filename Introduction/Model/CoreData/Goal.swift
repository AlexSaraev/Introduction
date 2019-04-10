//
//  Goal+CoreDataClass.swift
//  CrazyList
//
//  Created by Alex on 01/08/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//
//

import Foundation
import CoreData

class Goal: NSManagedObject {
    
    // MARK: - Properties
    @NSManaged var id: String
    @NSManaged var createdAt: Date
    @NSManaged var deadline: Date
    @NSManaged var goalNotification: GoalNotification?
    @NSManaged var dream: Dream!
    
    // MARK: - Static properties
    /// This key of userInfo dictionary for NotificationCenter, it gets Dream of the goal.
    static var notificationCenter = NotificationCenter.default
    
    // MARK: - Static methods
    static func createGoal(withDeadline deadline: Date, context: NSManagedObjectContext) -> Goal {
        let goal = Goal(context: context)
        goal.id = "user\(Date.init().timeIntervalSinceReferenceDate)"
        goal.createdAt = Date()
        goal.deadline = deadline
        
        context.save(descriptionOfChanges: "Creation new Dream")
        
        return goal
    }
    
    // MARK: - Methods of instances
    func save() {
        // 1
        context?.save(descriptionOfChanges: "Goal")
        // 2
        Goal.notificationCenter.post(name: NotificationNames.changingGoal, object: nil, userInfo: [Goal.NotificationKeys.goal: self])
    }
    
    func remove() {
        // 1
        let goalID = id
        // 2
        context?.delete(self)
        context?.save(descriptionOfChanges: "Deletion Goal")
        // 3
        Goal.notificationCenter.post(name: NotificationNames.deletingGoal, object: nil, userInfo: [NotificationKeys.identifierOfDeletedGoal: goalID])
    }
    
    // MARK: - NotificationNames and keys
    struct NotificationNames {
        static let changingGoal = Notification.Name("ChangingGoal")
        static let deletingGoal = Notification.Name(rawValue: "DeletingGoal")
    }
    
    struct NotificationKeys {
        /// The key for getting the goal from a dictionary of Notification
        static let goal = "Goal"
        /// The key for getting the id of deleted goal from a dictionary of Notification
        static let identifierOfDeletedGoal = "GoalID"
    }
}
