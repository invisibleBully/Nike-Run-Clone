//
//  Location.swift
//  Pace
//
//  Created by Junior on 19/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import Foundation
import Realm
import RealmSwift



class Location: Object {
    
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }

}
