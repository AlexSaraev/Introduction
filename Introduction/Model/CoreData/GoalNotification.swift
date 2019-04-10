//
//  GoalNotification+CoreDataClass.swift
//  CrazyList
//
//  Created by Alex on 01/08/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//
//

import Foundation
import CoreData

@objc class GoalNotification: NSObject, NSCoding {
    
    // MARK: - Properties
    var userSelectedNotificationDate: Date
    var repeatNotificationState: RepeatNotificationState
    
    // MARK: - Init
    init(userSelectedNotificationDate: Date, repeatNotificationState: RepeatNotificationState) {
        self.userSelectedNotificationDate = userSelectedNotificationDate
        self.repeatNotificationState = repeatNotificationState
        
        super.init()
    }
    
    // MARK: - NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let userSelectedNotificationDate = aDecoder.decodeObject(forKey: Keys.userSelectedNotificationDate) as? Date else {
                assertionFailure("Unexpectedly aDecoder has returned nil instead date.")
                return nil
        }
        let repeatNotificationStateRawValue = aDecoder.decodeInteger(forKey: Keys.repeatNotificationState)
        let repeatNotificationState = RepeatNotificationState(rawValue: repeatNotificationStateRawValue) ?? RepeatNotificationState.never
        
        self.init(userSelectedNotificationDate: userSelectedNotificationDate, repeatNotificationState: repeatNotificationState)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(repeatNotificationState.rawValue, forKey: Keys.repeatNotificationState)
        aCoder.encode(userSelectedNotificationDate, forKey: Keys.userSelectedNotificationDate)
    }
    
    // MARK: - RepeatNotificationState
    enum RepeatNotificationState: Int, CaseIterable {
        
        private static let localizedNeverStateText = NSLocalizedString("NEVER", comment: "RepeatNotificationState")
        private static let localizedEverydayStateText = NSLocalizedString("EVERYDAY", comment: "RepeatNotificationState")
        private static let localizedEveryWeekStateText = NSLocalizedString("ONCE_A_WEEK", comment: "RepeatNotificationState")
        private static let localizedEveryMonthStateText = NSLocalizedString("ONCE_A_MONTH", comment: "RepeatNotificationState")
        private static let localizedEveryYearStateText = NSLocalizedString("ONCE_A_YEAR", comment: "RepeatNotificationState")
        
        case never, everyday, everyWeek, everyMonth, everyYear
        
        var localizedStateText: String {
            switch self {
            case .never:
                return GoalNotification.RepeatNotificationState.localizedNeverStateText
            case .everyday:
                return GoalNotification.RepeatNotificationState.localizedEverydayStateText
            case .everyWeek:
                return GoalNotification.RepeatNotificationState.localizedEveryWeekStateText
            case .everyMonth:
                return GoalNotification.RepeatNotificationState.localizedEveryMonthStateText
            case .everyYear:
                return GoalNotification.RepeatNotificationState.localizedEveryYearStateText
            }
        }
    }
    
    // MARK: - Keys
    struct Keys {
        static let repeatNotificationState = "RepeatNotificationState"
        static let userSelectedNotificationDate = "UserSelectedNotificationDate"
    }
}
