//
//  WikiPage-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/8/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
import CoreData
@testable import WikiSearch

class WikiPage_Tests: XCTestCase {
    
    var container: NSPersistentContainer!
    
    override func setUp() {
        container = NSPersistentContainer(name: "WikiSearch")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        CoreDataStack.initialize(container: container) { (des, err) in
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
    }


    override func tearDown() {
        container = nil
        CoreDataStack.reset()
    }
    
    func test_WikiPage_Decoded() throws {

        let correctJSON = """
                {
                "title": "Apple",
                "pageid": 1000,
                "timestamp": "2020-05-07",
                "snippet": "some snippet",
                }
                """
        let decoder = JSONDecoder()
        let data = try XCTUnwrap(correctJSON.data(using: .utf8))
        let page = try XCTUnwrap(try? decoder.decode(WikiPage.self, from: data))
        XCTAssertEqual(page.title, "Apple")
        XCTAssertNil(page.url)
    }

    
    func test_WikiPage_Created() throws {
        var result = try CoreDataStack.shared.context.fetch(WikiPage.fetchRequest() as NSFetchRequest<WikiPage>)
        XCTAssertEqual(result.count, 0)
        let page = WikiPage(context: CoreDataStack.shared.context)
        page.title = "blabla"
        page.pageid = Int64(1234)
        page.snippet = "some text here"
        page.timestamp = "2020-05-15"
        try CoreDataStack.shared.context.save()
        result = try CoreDataStack.shared.context.fetch(WikiPage.fetchRequest() as NSFetchRequest<WikiPage>)
        XCTAssertEqual(result.count, 1)
    }
    
    func test_WikiPage_Throws_error_when_pageid_duplicate() throws {
        var result = try CoreDataStack.shared.context.fetch(WikiPage.fetchRequest() as NSFetchRequest<WikiPage>)
        XCTAssertEqual(result.count, 0)
        let page = WikiPage(context: CoreDataStack.shared.context)
        page.title = "blabla"
        page.pageid = Int64(1234)
        page.snippet = "some text here"
        page.timestamp = "2020-05-15"
        
        let page1 = WikiPage(context: CoreDataStack.shared.context)
        page1.title = "blabla"
        page1.pageid = Int64(1234)
        page1.snippet = "some text here"
        page1.timestamp = "2020-05-15"
        
        result = try CoreDataStack.shared.context.fetch(WikiPage.fetchRequest() as NSFetchRequest<WikiPage>)
        XCTAssertEqual(result.count, 2)
        XCTAssertThrowsError(try CoreDataStack.shared.context.save())
    }

}
