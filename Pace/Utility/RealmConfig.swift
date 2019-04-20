//
//  RealmConfig.swift
//  Pace
//
//  Created by Junior on 19/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


class RealmConfig {
    
    static var runDataConfig: Realm.Configuration {
        
        let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALM_RUN_CONFIG)
        let config = Realm.Configuration(
            fileURL: realmPath,
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 0) {
                    //Nothing to do
                    //Realm automatically detect new property and remove properties
                }
            })
        return config
    }
}
