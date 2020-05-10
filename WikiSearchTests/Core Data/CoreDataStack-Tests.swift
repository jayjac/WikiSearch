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
    
    var correctContainer: NSPersistentContainer!
    
    override func setUp() {
        correctContainer = NSPersistentContainer(name: "WikiSearch")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        correctContainer.persistentStoreDescriptions = [description]
    }
    
    override func tearDown() {
        correctContainer = nil
    }
    
    
    func test_Stack_Created_Successfully() throws {
        let expectation = XCTestExpectation(description: "no error")
        var storeDescription: NSPersistentStoreDescription? = nil
        CoreDataStack.initialize(container: correctContainer, completionClosure: { (descrip: NSPersistentStoreDescription, err: Error?) in
            // This closure is called when Model file OK
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
            // This closure is never called when model file name erroneous
            storeDescription = descrip
        })
        Thread.sleep(forTimeInterval: 1.0)
        XCTAssertNil(storeDescription)
    }
    


}
