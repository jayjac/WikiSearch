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
    
    func saveSnippetToPages(snippetResults: [SnippetSearchResult], in context: NSManagedObjectContext) {
        context.performAndWait {
            for snippet in snippetResults {
                let predicate = NSPredicate(format: "pageid == %@", snippet.pageid.toString)
                let request = NSFetchRequest<WikiPage>(entityName: "WikiPage")
                request.predicate = predicate
                do {
                    let pages = try context.fetch(request)
                    
                    if let page = pages.first {
                        page.snippet = snippet.snippet
                        try context.save()
                    }
                } catch {}
            }
        }
    }
    
    func retrievePages(with ids: [String], in context: NSManagedObjectContext) -> [WikiPage] {
        let predicate = NSPredicate(format: "pageid in (%@)", ids)
        let request: NSFetchRequest<WikiPage> = WikiPage.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        guard let results = try? context.fetch(request) else {
            return [WikiPage]()
        }
        return results
    }
    
    
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
