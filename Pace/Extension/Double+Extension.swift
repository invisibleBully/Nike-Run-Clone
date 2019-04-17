//
//  Double+Extension.swift
//  Pace
//
//  Created by Junior on 17/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import Foundation


extension Double {
    
    func metersToMiles(places: Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return ((self / 1609.34) * divisor).rounded() / divisor
    }
    
}
