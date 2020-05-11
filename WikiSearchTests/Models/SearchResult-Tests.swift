//
//  SearchResult-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class SearchResult_Tests: XCTestCase {
    
    let correctJSON = """
            {
            "title": "Apple",
            "pageid": 1000,
            "timestamp": "2020-05-07",
            "snippet": "some snippet",
            }
            """
    
    let incorrectJSON = """
            {
            "title": "Apple",
            "pageid": 1000,
            "timestamp": "2020-05-07",
            }
            """

    
    func test_SearchResult_created() throws {
        let data = try XCTUnwrap(correctJSON.data(using: .utf8))
        let result = try XCTUnwrap(try? JSONDecoder().decode(SnippetSearchResult.self, from: data))
        XCTAssertEqual(result.pageid, 1000)
    }
    
    func test_SearchResult_NOT_created() throws {
        let data = try XCTUnwrap(incorrectJSON.data(using: .utf8))
        let result = try? JSONDecoder().decode(SnippetSearchResult.self, from: data) //Missing snippet
        XCTAssertNil(result)
    }

}
