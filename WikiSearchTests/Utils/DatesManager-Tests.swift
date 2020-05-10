//
//  DatesManager.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/9/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch


class DatesManager_Tests: XCTestCase {

    
    func test_Date_Created() throws {
        let date = try XCTUnwrap(DatesManager.date(from: "2020-05-08T02:41:50Z"))
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        XCTAssertEqual(calendar.component(.year, from: date), 2020)
        XCTAssertEqual(calendar.component(.month, from: date), 5)
        XCTAssertEqual(calendar.component(.day, from: date), 8)
        XCTAssertEqual(calendar.component(.hour, from: date), 2)
        XCTAssertEqual(calendar.component(.minute, from: date), 41)
        XCTAssertEqual(calendar.component(.second, from: date), 50)
    }

}
