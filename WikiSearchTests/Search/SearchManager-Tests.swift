//
//  SearchManager-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class SearchManager_Tests: XCTestCase {



    func test_Correct_URL_Generated() throws {
        let url = SearchManager.generateSnippetSearchURL(page: 0, for: "blabla")
        XCTAssertEqual(url.scheme, "https")
    }


}
