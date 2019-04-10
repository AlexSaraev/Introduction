//
//  Dream+CoreDataClass.swift
//  CrazyList
//
//  Created by Alex on 01/08/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//
//

import UIKit
import CoreData

class Dream: NSManagedObject {
    
    // MARK: - Properties
    @NSManaged var achievedAt: Date?
    @NSManaged var createdAt: Date
    @NSManaged var id: String
    @NSManaged var note: String?
    @NSManaged var picture: UIImage?
    @NSManaged var target: String
    @NSManaged var goal: Goal?
    @NSManaged var list: List?
    
    static let notificationKey = "DreamKey"
    static let fetchBatchSize = 10
    
    static var notificationCenter = NotificationCenter.default
    
    // MARK: - Static methods of creating dream
    static func createOrGetDreamWith(with defaultDream: DefaultDream, context: NSManagedObjectContext) -> Dream {
        let request = NSFetchRequest<Dream>(entityName: "Dream")
        request.predicate = NSPredicate(format: "id == %@", defaultDream.id)
        
        if let dream = (try? context.fetch(request))?.first {
            return dream
        } else {
            let dream = Dream(context: context)
            dream.id = defaultDream.id
            dream.target = defaultDream.target
            dream.createdAt = Date()
            
            if let pictureData = try? Data(contentsOf: URL(fileReferenceLiteralResourceName: defaultDream.literalPictureName)) {
                dream.picture = UIImage(data: pictureData)
            }
            
            context.save(descriptionOfChanges: "Creation the Dream with the id")
            
            return dream
        }
    }

    // MARK: - Save and remove dream methods
    func save() {
        context?.save(descriptionOfChanges: "Dream")
        
        Dream.notificationCenter.post(name: NotificationNames.changingDream, object: nil, userInfo: [Dream.notificationKey: self])
    }
    
    func remove() {
        context?.delete(self)
        context?.save(descriptionOfChanges: "Deletion Dream")
        
        Dream.notificationCenter.post(name: NotificationNames.deletingDream, object: nil, userInfo: [Dream.notificationKey: self])
    }
    
    // MARK: - Goal interactions
    func setGoal(withDeadline deadline: Date) {
        guard let context = context else { return }
        
        let goal = Goal.createGoal(withDeadline: deadline, context: context)
        self.goal = goal
        
        context.save(descriptionOfChanges: "Dream with the Goal")
        
        Dream.notificationCenter.post(name: NotificationNames.settingGoal, object: nil, userInfo: [Dream.notificationKey: self])
    }
    
    func achieve() {
        achievedAt = Date()
        goal?.remove()
        
        context?.save(descriptionOfChanges: "Dream with the Achievement date")
        
        Dream.notificationCenter.post(name: NotificationNames.achievingDream, object: nil, userInfo: [Dream.notificationKey: self])
    }
    
    func fail() {
        goal?.remove()
        
        context?.save(descriptionOfChanges: "Failing the goal with swapping the failed dream to first index in the list")
        
        Dream.notificationCenter.post(name: NotificationNames.failingDream, object: nil, userInfo: [Dream.notificationKey: self])
    }
    
    func resetAchievement() {
        achievedAt = nil
        
        context?.save(descriptionOfChanges: "Reseting achievement with swapping the dream to first index in the list")
        
        Dream.notificationCenter.post(name: NotificationNames.resettingAchievedDream, object: nil, userInfo: [Dream.notificationKey: self])
    }
    
    // MARK: - NotificationNames
    struct NotificationNames {
        static let changingDream = Notification.Name("ChangingDream")
        static let deletingDream = Notification.Name("DeletingDream")
        static let settingGoal = Notification.Name("SettingGoal")
        static let achievingDream = Notification.Name(rawValue: "AchievingDream")
        static let failingDream = Notification.Name(rawValue: "FailingDream")
        static let resettingAchievedDream = Notification.Name(rawValue: "ResettingAchievedDream")
    }
    
}
