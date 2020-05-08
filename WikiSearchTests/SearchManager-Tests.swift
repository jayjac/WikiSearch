//
//  SearchManager-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class SearchManager_Tests: XCTestCase {
    
    class MockDelegate: SearchManagerDelegate {
        func searchManagerDidFindResults() {
            
        }
        
        
    }

    func test_Generate_URL() {
//        let searchManager = SearchManager(delegate: MockDelegate())
//        let url = searchManager.generateSearchURL(for: "two words")
//        XCTAssertEqual(url.scheme, "https")
//        XCTAssertEqual(url.host, "en.wikipedia.org")
//        XCTAssertTrue(url.absoluteString.hasSuffix("&srsearch=two%20words"))
    }

}
