//
//  DatesManager.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/9/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation

/*
 * Only contains static methods
 */
struct DatesManager {
    
    private init() {}
    
    private static let inDateFormatter: DateFormatter = {
        let fm = DateFormatter()
        fm.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return fm
    }()
    
    private static let outDateFormatter: DateFormatter = {
        let fm = DateFormatter()
        fm.dateStyle = .medium
        fm.timeStyle = .medium
        return fm
    }()
    
    static func date(from string: String) -> Date? {
        return inDateFormatter.date(from: string)
    }
    
    static func humanReadableDateString(from date: Date, locale: Locale = Locale.current, timeZone: TimeZone = TimeZone.current) -> String {
        outDateFormatter.locale = locale
        outDateFormatter.timeZone = timeZone
        return outDateFormatter.string(from: date)
    }
    
}
