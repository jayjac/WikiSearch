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
    func searchManagerDidFindResults()
}

/*
 * Performs WikiPedia's actual search
 */
class SearchManager {

    private weak var delegate: SearchManagerDelegate?
    //private(set) var searchResults: [SearchResultViewModel] = [SearchResultViewModel]()
    private(set) var searchResults: [SearchResultProtocol] = [SearchResultProtocol]()
    private let queue = OperationQueue()

    
    init(delegate: SearchManagerDelegate) {
        self.delegate = delegate
        queue.qualityOfService = .userInitiated
    }
    
    //https://it.wikipedia.org/w/api.php?action=query&generator=search&gsrsearch=calvino&format=json&gsrprop=snippet&prop=info&inprop=url&gsrlimit=500
    
    static func generateSnippetSearchURL(page: Int,
                                  for query: String,
                                  language: String = "en") -> URL {
        guard var urlComponents = URLComponents(string: Constants.wikipediaBaseURLString) else { fatalError() }
        let actionQI = URLQueryItem(name: "action", value: "query")
        let offsetQI = URLQueryItem(name: "sroffset", value: page.toString)
        let listQI = URLQueryItem(name: "list", value: "search")
        let limitQI = URLQueryItem(name: "srlimit", value: Constants.resultsCount.toString)
        let formatQI = URLQueryItem(name: "format", value: "json")
        let searchQI = URLQueryItem(name: "srsearch", value: query)
        urlComponents.queryItems = [actionQI, offsetQI, limitQI, formatQI, listQI, searchQI]
        return urlComponents.url!
    }
    

    func clearAllResults() {
        searchResults.removeAll()
    }
    

    /*
     * Fetches the URLs of the matching articles first
     * Then fetches the Snippets of the matching articles
     */
    func search(for text: String, operations: [SearchOperation]? = nil) {
        queue.cancelAllOperations()
        let ops = operations ?? [SearchOperation(searchText: text, page: 0, type: .url),
                                 SearchOperation(searchText: text, page: 1, type: .url)]
        queue.addOperations(ops, waitUntilFinished: true)
        
        let pageIDs = ops.flatMap { $0.pagesObjectIDS }
        let ops2 = [SearchOperation(searchText: text, page: 0, type: .snippet), SearchOperation(searchText: text, page: 1, type: .snippet)]
        queue.addOperations(ops2, waitUntilFinished: true)
        
        let snippets: [SnippetSearchResult] = ops.flatMap { $0.searchResultArray }
        var snippetDictionary: [Int: String] = [Int: String]()
        snippets.forEach { (res: SnippetSearchResult) in
            snippetDictionary[res.pageid] = res.snippet
        }
        
        let backgroundContext = CoreDataStack.shared.persistentContainer.newBackgroundContext()
        backgroundContext.automaticallyMergesChangesFromParent = true
        // Adding snippet property to objects
        backgroundContext.performAndWait {
            pageIDs.forEach { (objectID: NSManagedObjectID) in
                let page = backgroundContext.object(with: objectID) as! WikiPage
                let id = Int(page.pageid)
                // If a snippet exists
                guard let matchingSnippet = snippetDictionary[id] else {
                    return
                }
                page.snippet = matchingSnippet
            }
            
        }
        backgroundContext.reset()
        do {
            try backgroundContext.save()
        } catch {}
        DispatchQueue.main.async {
            let viewContext = CoreDataStack.shared.context
            let wikiPages = pageIDs.map { viewContext.object(with: $0) as! WikiPage }
            self.searchResults = wikiPages
        }
        
    }
}
