//
//  DatesManager.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/9/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation


struct DatesManager {
    
    private static let dateFormatter: DateFormatter = {
        let fm = DateFormatter()
        fm.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return fm
    }()
    
    static func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
}
