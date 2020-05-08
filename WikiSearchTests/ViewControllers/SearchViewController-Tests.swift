//
//  SearchViewController-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class SearchViewController_Tests: XCTestCase {



    func test_SearchVC_is_searchbar_delegate() throws {
        let searchVC = SearchViewController()
        _ = searchVC.view
        XCTAssertTrue(searchVC.searchBar.delegate === searchVC)
    }
    
    func test_SearchVC_tableview_has_datasource() throws {
        let searchVC = SearchViewController()
        _ = searchVC.view
        XCTAssertNotNil(searchVC.tableView.dataSource)
    }



}
