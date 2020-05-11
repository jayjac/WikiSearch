//
//  SearchResultViewModel-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/10/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class SearchResultViewModel_Tests: XCTestCase {
    
    struct MockSearchResult: SearchResultProtocol {
        var title: String?
        var snippet: String?
        var fullURL: URL?
        var lastRevision: Date?
    }
    
    class MockDelegate: SearchResultViewModelDelegate {
        private(set) var openCalled = false
        
        func openSearchResultURL(url: URL) {
            openCalled = true
        }
    }


    func test_ViewModel_Behaves_OK() throws {
        let now = Date()
        let mockResult = MockSearchResult(title: "someTitle", snippet: nil, fullURL: URL(string: "bla"), lastRevision: now)
        let delegate = MockDelegate()
        let viewModel = SearchResultViewModel(result: mockResult, delegate: delegate)
        XCTAssertEqual(viewModel.title, mockResult.title)
        XCTAssertEqual(viewModel.snippetHTML, "")
        XCTAssertFalse(delegate.openCalled)
        viewModel.openURL()
        XCTAssertTrue(delegate.openCalled)
        XCTAssertEqual(viewModel.lastEditHumanReadableTime, DatesManager.humanReadableDateString(from: now))
    }



}
