//
//  CoreDataStack-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/8/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
import CoreData
@testable import WikiSearch

class CoreDataStack_Tests: XCTestCase {


    func test_Stack_Created() throws {
        let container = NSPersistentContainer(name: "WikiSearch")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        let expectation = XCTestExpectation(description: "no error")
        var storeDescription: NSPersistentStoreDescription? = nil
        CoreDataStack.initialize(container: container, completionClosure: { (descrip: NSPersistentStoreDescription, err: Error?) in
            storeDescription = descrip
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(storeDescription)
    }
    
    func test_Stack_Not_Created_Because_Wrong_Model_Name() throws {
        let container = NSPersistentContainer(name: "WkSrch")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        var storeDescription: NSPersistentStoreDescription? = nil
        CoreDataStack.initialize(container: container, completionClosure: { (descrip: NSPersistentStoreDescription, err: Error?) in
            storeDescription = descrip
        })
        Thread.sleep(forTimeInterval: 1.0)
        XCTAssertNil(storeDescription)
    }


}
