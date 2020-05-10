//
//  Constants-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/8/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class Constants_Tests: XCTestCase {



    func test_Search_Base_URL() throws {
        let englishBaseURL = "https://en.wikipedia.org/w/api.php"
        XCTAssertEqual(englishBaseURL, Constants.wikipediaSearchBaseURL(language: "en"))
        let italianBaseURL = "https://it.wikipedia.org/w/api.php"
        XCTAssertEqual(italianBaseURL, Constants.wikipediaSearchBaseURL(language: "it"))
    }

}
