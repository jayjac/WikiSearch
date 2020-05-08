//
//  SearchManager.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation


protocol SearchManagerDelegate: class {
    func searchManagerDidFindResults()
}

/*
 * Performs WikiPedia's actual search
 */
class SearchManager {

    private weak var delegate: SearchManagerDelegate?
    private(set) var searchResults: [SearchResult] = [SearchResult]()
    private let queue = OperationQueue()

    
    init(delegate: SearchManagerDelegate) {
        self.delegate = delegate
        queue.qualityOfService = .userInitiated
    }
    
    static func generateSearchURL(page: Int, for query: String, language: String = "en") -> URL {
        guard var urlComponents = URLComponents(string: Constants.wikipediaBaseURLString) else { fatalError() }
        let actionQI = URLQueryItem(name: "action", value: "query")
        let offsetQI = URLQueryItem(name: "sroffset", value: "\(page)")
        let listQI = URLQueryItem(name: "list", value: "search")
        let limitQI = URLQueryItem(name: "srlimit", value: "500")
        let formatQI = URLQueryItem(name: "format", value: "json")
        let searchQI = URLQueryItem(name: "srsearch", value: query)
        urlComponents.queryItems = [actionQI, offsetQI, limitQI, formatQI, listQI, searchQI]
        return urlComponents.url!
    }
    

    func clearAllResults() {
        searchResults.removeAll()
    }
    

    func search(for text: String, operations: [SearchOperation]? = nil) {
        queue.cancelAllOperations()
        let ops = operations ?? [SearchOperation(searchText: text, page: 0), SearchOperation(searchText: text, page: 1)]
        queue.addOperations(ops, waitUntilFinished: false)
        queue.addBarrierBlock {
            DispatchQueue.main.async {
                self.searchResults = ops.flatMap({
                    $0.searchResultArray
                })
                self.delegate?.searchManagerDidFindResults()
            }
        }
    }
}
