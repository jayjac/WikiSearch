//
//  UITableViewCell+ReuseIdentifier-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class JayTableViewCell: UITableViewCell {} // Must not be an inner class

class UITableViewCell_ReuseIdentifier_Tests: XCTestCase {

    

    func test_Tablecells_have_a_reuse_id() throws {
        XCTAssertEqual(UITableViewCell.reuseIdentifier, "UITableViewCell")
        XCTAssertEqual(JayTableViewCell.reuseIdentifier, "JayTableViewCell")
    }


    func test_TableView_dequeues_correct_cell_type() throws {
        let tableView = UITableView()
        tableView.registerCellType(JayTableViewCell.self)
        XCTAssertNoThrow(tableView.dequeueCellType(JayTableViewCell.self))
    }

}
