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
    
    @objc dynamic var id = ""
    @objc dynamic var date = NSDate()
    @objc dynamic var pace = 0
    @objc dynamic var distance = 0.0
    @objc dynamic var duration = 0
    dynamic var locations = List<Location>()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    override static func indexedProperties() -> [String] {
        return [
            "pace",
            "date",
            "duration"
        ]
    }
    
    convenience init(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.id =  UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.locations = locations
    }
    
    
    static func addRunToRealm(pace: Int, distance: Double, duration: Int, locations: List<Location>){
        //create realm instance for everytime to write and everytime you read
        let runObject = Run(pace: pace, distance: distance, duration: duration, locations: locations)
        REAL_QUEUE.sync {
            do {
                let realm = try Realm(configuration: RealmConfig.runDataConfig)
                try realm.write {
                    realm.add(runObject)
                    try realm.commitWrite()
                    debugPrint("Added Run Object To Realm...")
                }
            }catch{
                debugPrint("Error Adding Run Object To Realm...")
            }
        }
    }
    
    
    static func getAllRuns() -> Results<Run>? {
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: true)
            return runs
        }catch{
            return nil
        }
    }
    
    
}
