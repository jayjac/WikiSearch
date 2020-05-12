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
    func searchManagerDidFail(with error: Error)
}

/*
 * Performs WikiPedia's actual search
 */
class SearchManager {

    private weak var delegate: SearchManagerDelegate?
    private let queue = OperationQueue()
    private(set) var previousSearch: [String: [String]] = [String: [String]]()

    
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
        let objectsManager = ObjectsManager()
        let viewContext = CoreDataStack.shared.viewContext
        let key = text.lowercased().trimmingCharacters(in: .whitespaces)
        
        // If recently searched this term, don't hit the server
        if let prev = previousSearch[key] {
            let results = objectsManager.retrievePages(with: prev, in: viewContext)
            self.delegate?.searchManagerDidFindResults(results)
            return
        }
        
        let urlSearchOperation = operation ?? SearchOperation(searchText: text, page: 0, type: .url)
        queue.addOperation(urlSearchOperation)

        let snippetSearchOperation = SearchOperation(searchText: text, page: 0, type: .snippet)
        snippetSearchOperation.addDependency(urlSearchOperation)
        queue.addOperation(snippetSearchOperation)
        
       

        queue.addBarrierBlock {
            let snippets = snippetSearchOperation.snippetSearchResults // keep it in barrier block or else it is empty
            if let err = urlSearchOperation.operationError {
                self.delegate?.searchManagerDidFail(with: err)
                return
            }
            let backgroundContext = CoreDataStack.shared.backgroundContext
            backgroundContext.automaticallyMergesChangesFromParent = true
            objectsManager.saveSnippetToPages(snippetResults: snippets, in: backgroundContext)
            
            //backgroundContext.reset()
            DispatchQueue.main.async {
                do {
                    try viewContext.save()
                } catch {}
                
                let pageids = snippets.map { $0.pageid.toString }
                let wikiPages = objectsManager.retrievePages(with: pageids, in: viewContext)
                self.previousSearch[key] = pageids
                self.delegate?.searchManagerDidFindResults(wikiPages)
                
            }
        } 
    }
}
