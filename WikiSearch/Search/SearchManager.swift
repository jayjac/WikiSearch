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
        
        let urlSearchOperation = operation ?? SearchOperation(searchText: text, page: 0, type: .url)
        queue.addOperation(urlSearchOperation)
        
        let snippetSearchOperation = SearchOperation(searchText: text, page: 0, type: .snippet)
        snippetSearchOperation.addDependency(urlSearchOperation)
        queue.addOperation(snippetSearchOperation)

        queue.addBarrierBlock {
 
            let backgroundContext = CoreDataStack.shared.backgroundContext
            backgroundContext.automaticallyMergesChangesFromParent = true
            //print(pageIDDictionary)
            //print(snippetSearchOperation.snippetSearchResults)
            backgroundContext.performAndWait {
                let snippetResults = snippetSearchOperation.snippetSearchResults
                for snippet in snippetResults {
                    let predicate = NSPredicate(format: "pageid == %@", snippet.pageid.toString)
                    let request = NSFetchRequest<WikiPage>(entityName: "WikiPage")
                    request.predicate = predicate
                    do {
                        let pages = try backgroundContext.fetch(request)
                        if let page = pages.first {
                            page.snippet = snippet.snippet
                            try backgroundContext.save()
                        }
                    } catch {}
                }
            }

            
            backgroundContext.reset()
            DispatchQueue.main.async {
                let viewContext = CoreDataStack.shared.viewContext
                do {
                    try viewContext.save()
                } catch {}
                let snippets = snippetSearchOperation.snippetSearchResults
                //print(snippets)
                var wikiPages = [WikiPage]()
                let pageids = snippets.map { $0.pageid.toString }
                let predicate = NSPredicate(format: "pageid in (%@)", pageids)
                let request: NSFetchRequest<WikiPage> = WikiPage.fetchRequest()
                request.returnsObjectsAsFaults = false
                request.predicate = predicate
                let results = try? viewContext.fetch(request)
                if let results = results {
                    wikiPages = results
                }
//                do {
//                    try viewContext.save()
//                } catch {}
                self.delegate?.searchManagerDidFindResults(wikiPages)
                
            }
        } 
    }
}
