//
//  ObjectsManager-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/10/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
import CoreData
@testable import WikiSearch

class ThrowingMockContext: ManagedContextProtocol {
    var mergePolicy: Any = ""
    
    func save() throws {
        throw NSError(domain: "jay", code: 973, userInfo: nil)
    }
    
    func performAndWait(_ block: () -> Void) {
        block()
    }
    
    
}

class ObjectsManager_Tests: XCTestCase {
    
    let json: String = """
{"batchcomplete":"","continue":{"gsroffset":2,"continue":"gsroffset||"},"query":{"pages":{"41284488":{"pageid":41284488,"ns":0,"title":"Death of Nelson Mandela","index":2,"contentmodel":"wikitext","pagelanguage":"en","pagelanguagehtmlcode":"en","pagelanguagedir":"ltr","touched":"2020-05-10T16:07:29Z","lastrevid":955146720,"length":135118,"fullurl":"https://en.wikipedia.org/wiki/Death_of_Nelson_Mandela","editurl":"https://en.wikipedia.org/w/index.php?title=Death_of_Nelson_Mandela&action=edit","canonicalurl":"https://en.wikipedia.org/wiki/Death_of_Nelson_Mandela"},"21492751":{"pageid":21492751,"ns":0,"title":"Nelson Mandela","index":1,"contentmodel":"wikitext","pagelanguage":"en","pagelanguagehtmlcode":"en","pagelanguagedir":"ltr","touched":"2020-05-10T11:53:48Z","lastrevid":954009272,"length":198487,"fullurl":"https://en.wikipedia.org/wiki/Nelson_Mandela","editurl":"https://en.wikipedia.org/w/index.php?title=Nelson_Mandela&action=edit","canonicalurl":"https://en.wikipedia.org/wiki/Nelson_Mandela"}}}}
"""


 
    func test_Manager_Decodes_OK() throws {
        let container = NSPersistentContainer(name: "WikiSearch")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        let group = DispatchGroup()
        group.enter()
        CoreDataStack.initialize(container: container) { (_, _) in
            group.leave()
        }
        group.wait()
        let data = try XCTUnwrap(json.data(using: .utf8))
        let manager = ObjectsManager()
        XCTAssertNoThrow(_ = try manager.decodeURLAPIResponse(from: data))
        let ids: [String: NSManagedObjectID] = try! manager.decodeURLAPIResponse(from: data)
        XCTAssertEqual(ids.count, 2)
    }
    
    func test_Manager_Throws_Error() throws {
        let container = NSPersistentContainer(name: "WikiSearch")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        let group = DispatchGroup()
        group.enter()
        CoreDataStack.initialize(container: container) { (_, _) in
            group.leave()
        }
        group.wait()
        let data = try XCTUnwrap(json.data(using: .utf8))
        let manager = ObjectsManager()
        let context = ThrowingMockContext()
        
        XCTAssertThrowsError(try manager.decodeURLAPIResponse(from: data, context: context))
        XCTAssertTrue(context.mergePolicy as AnyObject === NSMergeByPropertyObjectTrumpMergePolicy)
    }
    
    
     //   func test_WikiPages_Decoded_from_JSON() throws {
    //        let container = NSPersistentContainer(name: "WikiSearch")
    //        let description = NSPersistentStoreDescription()
    //        description.type = NSInMemoryStoreType
    //        container.persistentStoreDescriptions = [description]
    //        let group = DispatchGroup()
    //        group.enter()
    //        CoreDataStack.initialize(container: container) { (_, _) in
    //            group.leave()
    //        }
    //        group.wait()
    //        let data = try XCTUnwrap(json.data(using: .utf8))
    //
    //        let response = try XCTUnwrap(try? JSONDecoder().decode(URLAPIResponse.self, from: data))
    //        let pages = response.query.pages
    //
    //        XCTAssertEqual(pages.count, 2)
    //        let page = try XCTUnwrap(pages["41284488"])
    //        XCTAssertEqual(page.fullURL?.absoluteString, "https://en.wikipedia.org/wiki/Death_of_Nelson_Mandela")
    //        XCTAssertEqual(page.language, "en")
    //    }

}
