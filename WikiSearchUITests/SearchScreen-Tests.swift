//
//  WikiSearchUITests.swift
//  WikiSearchUITests
//
//  Created by Jay Jac on 5/2/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class SearchScreen_Tests: XCTestCase {


    
    func test_Components_Exist() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.tables["ResultsTableView"].exists)
    }



//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
