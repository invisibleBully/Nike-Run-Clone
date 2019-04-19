//
//  Date+Extension.swift
//  Pace
//
//  Created by Junior on 19/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import Foundation


extension NSDate {
    func getDateString() -> String {
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from:  self as Date)
        let day = calendar.component(.day, from: self as Date)
        let year = calendar.component(.year, from: self as Date)
        
        return "\(month)/\(day)/\(year)"
    }
    
}
