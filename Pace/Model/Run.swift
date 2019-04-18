//
//  Run.swift
//  Pace
//
//  Created by Junior on 18/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import Foundation
import RealmSwift
import Realm



class Run: Object {
    
    dynamic public private(set) var id = ""
    dynamic public private(set) var date = NSDate()
    dynamic public private(set) var pace = 0
    dynamic public private(set) var distance = 0.0
    dynamic public private(set) var duration = 0
    
    override class func primaryKey() -> String{
        return "id"
    }
    
    
    override class func indexedProperties() -> [String] {
        
        return [
            "pace",
            "date",
            "duration"
        ]
    }
    
    convenience init(pace: Int, distance: Double, duration: Int) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
    }
    
    
    
}
