//
//  ObjectsManager.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/10/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import CoreData

protocol ManagedContextProtocol: class {
    var mergePolicy: Any { get set }
    func save() throws
    func performAndWait(_ block: () -> Void)
}


extension NSManagedObjectContext: ManagedContextProtocol {}
/*
 * Handles the CoreData API to create and fetch WikiPage objects
 */
class ObjectsManager {
    
    
    func decodeURLAPIResponse(from data: Data,
                              context: ManagedContextProtocol = CoreDataStack.shared.backgroundContext) throws -> [String: NSManagedObjectID] {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        var objectIDs = [String: NSManagedObjectID]()
        var error: Error?
        context.performAndWait {
            do {
                let response = try JSONDecoder().decode(URLAPIResponse.self, from: data)
                try context.save()
                let pagesDictionary = response.query.pages
                objectIDs = pagesDictionary.mapValues { (page) -> NSManagedObjectID in
                    return page.objectID
                }
            } catch let err {
                error = err
            }
        }
        if let e = error {
            throw e
        }
        return objectIDs
    }
    
}
