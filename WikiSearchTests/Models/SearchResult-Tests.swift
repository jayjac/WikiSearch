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
        let result = try XCTUnwrap(try? JSONDecoder().decode(SearchResult.self, from: data))
        XCTAssertEqual(result.title, "Apple")
    }
    
    func test_SearchResult_NOT_created() throws {
        let data = try XCTUnwrap(incorrectJSON.data(using: .utf8)) //Missing snippet
        let result = try? JSONDecoder().decode(SearchResult.self, from: data)
        XCTAssertNil(result)
    }

    func test_HTML() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let searchResult = SearchResult(title: "", pageid: 12, snippet: "MY SNIPPET", timestamp: "")
        let html = """
                    <!doctype html>
                    <html>
                    <head>
                    <style>
                    body { font-size: 18pt; font-family: "Arial", sans-serif; }
                    .searchmatch { background-color: yellow; }
                    </style>
                    </head>
                    <body>
                    MY SNIPPET
                    </body>
                    </html>
                    """.trimmingCharacters(in: .whitespacesAndNewlines)
        XCTAssertEqual(searchResult.snippetHTML.trimmingCharacters(in: .whitespacesAndNewlines), html)
    }



}
