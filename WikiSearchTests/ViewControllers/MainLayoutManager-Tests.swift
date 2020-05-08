//
//  MainLayoutManager-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import XCTest
@testable import WikiSearch

class MainLayoutManager_Tests: XCTestCase {


    func test_MainLayoutManager_adds_elements() throws {
        let view = UIView()
        let tableView = UITableView()
        let searchBar = UISearchBar()
        let layout = MainLayoutManager(rootView: view, tableView: tableView, searchBar: searchBar)
        XCTAssertEqual(view.subviews.count, 0)
        layout.setupUI()
        XCTAssertEqual(view.subviews.count, 2)
        XCTAssertEqual(view.subviews[0], searchBar)
        XCTAssertEqual(view.subviews[1], tableView)
    }


}
