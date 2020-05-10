//
//  SearchManager.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation
import CoreData


protocol SearchManagerDelegate: class {
    func searchManagerDidFindResults(_ results: [SearchResultProtocol])
}

/*
 * Performs WikiPedia's actual search
 */
class SearchManager {

    private weak var delegate: SearchManagerDelegate?
    private let queue = OperationQueue()

    
    init(delegate: SearchManagerDelegate) {
        self.delegate = delegate
        queue.qualityOfService = .userInitiated
    }
    

    


    

    /*
     * Fetches the URLs of the matching articles first
     * Then fetches the Snippets of the matching articles
     */
    func search(for text: String, operation: SearchOperation? = nil) {
        queue.cancelAllOperations()
        
        let op = operation ?? SearchOperation(searchText: text, page: 0, type: .url)
        queue.addOperation(op)
        
        let op2 = SearchOperation(searchText: text, page: 0, type: .snippet)
        op2.addDependency(op)
        queue.addOperation(op2)
        
        queue.addBarrierBlock {
            let pageIDs = op.pagesObjectIDS
            print(pageIDs)
            var snippetDictionary: [Int: String] = [Int: String]()
            op2.searchResultArray.forEach { (result: SnippetSearchResult) in
                snippetDictionary[result.pageid] = result.snippet
            }
            let backgroundContext = CoreDataStack.shared.backgroundContext
            backgroundContext.automaticallyMergesChangesFromParent = true
            backgroundContext.performAndWait {
                pageIDs.forEach { (objectID: NSManagedObjectID) in
                    let page = backgroundContext.object(with: objectID) as! WikiPage
                    let id = Int(page.pageid)
                    // If a snippet exists
                    print(page.title)
                    if let matchingSnippet = snippetDictionary[id] {
                        page.snippet = matchingSnippet
                    }
                    
                }
            }
            do {
                try backgroundContext.save()
            } catch {}
            backgroundContext.reset()
            DispatchQueue.main.async {
                let viewContext = CoreDataStack.shared.viewContext
                let wikiPages = pageIDs.map { viewContext.object(with: $0) as! WikiPage }
                self.delegate?.searchManagerDidFindResults(wikiPages)
                
            }
        } 
    }
}
