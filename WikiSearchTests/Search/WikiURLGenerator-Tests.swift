//
//  WikiURLGenerator.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/10/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class WikiURLGenerator_Tests: XCTestCase {



    func test_Snippet_URL() throws {
        let italianUrl = WikiURLGenerator.generateSnippetSearchURL(page: 15, for: "Apple Challenge", language: "it")
        XCTAssertEqual(italianUrl.host, "it.wikipedia.org")
        
        let url = WikiURLGenerator.generateSnippetSearchURL(page: 15, for: "Apple Challenge", language: "en")
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "en.wikipedia.org")
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let items = try XCTUnwrap(components.queryItems)
        XCTAssertEqual(items.count, 6)
        var searchPresent = false
        for item in items {
            if item.name == "srsearch" {
                searchPresent = true
                XCTAssertEqual(item.value, "Apple Challenge")
            }
        }
        XCTAssertTrue(searchPresent)
    }
    
    
    func test_URLSearch_URL() throws {
        let italianUrl = WikiURLGenerator.generateURLSearchURL(page: 15, query: "Apple Challenge", language: "it")
        XCTAssertEqual(italianUrl.host, "it.wikipedia.org")
        
        let url = WikiURLGenerator.generateURLSearchURL(page: 20, query: "Apple Interview", language: "fr")
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "fr.wikipedia.org")
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let items = try XCTUnwrap(components.queryItems)

        var searchPresent = false
        for item in items {
            if item.name == "gsrsearch" {
                searchPresent = true
                XCTAssertEqual(item.value, "Apple Interview")
            }
        }
        XCTAssertTrue(searchPresent)
    }


}
