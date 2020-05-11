//
//  SearchOperation.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation
import CoreData

/*
 * One query that returns the article's full URL and one that returns the Snippet
 */
enum SearchOperationType {
    case snippet
    case url
}


/*
 * Queries WikiPedia
 */
class SearchOperation: Operation {
    
    private let type: SearchOperationType
    private let request: URLRequest
    private let page: Int
    private let searchText: String
    private(set) var snippetSearchResults: [SnippetSearchResult] = [SnippetSearchResult]()
    private(set) var pagesObjectIDDictionary: [String: NSManagedObjectID] = [String: NSManagedObjectID]()
    private var urlSession: URLSessionProtocol?
    private(set) var operationError: Error?
    
    
    init(searchText: String,
         page: Int,
         type: SearchOperationType) {
        self.type = type
        self.page = page
        self.searchText = searchText
        let url = type == SearchOperationType.snippet ? WikiURLGenerator.generateSnippetSearchURL(page: page, for: searchText) : WikiURLGenerator.generateURLSearchURL(page: page, query: searchText)
        self.request = URLRequest(url: url)
    }
    
    private func parseData(data: Data?) throws {
        guard let data = data else { return }
        switch type {
        case .snippet:
            guard let apiResponse = SnippetAPIResponse.parseSnippetResponse(data: data) else {
                return
            }
            snippetSearchResults = apiResponse.query.search
            
        case .url:
            let objectsManager = ObjectsManager()
            pagesObjectIDDictionary = try objectsManager.decodeURLAPIResponse(from: data)
        }
    }

    
    override func main() {
        if isCancelled {
            return
        }
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let session = urlSession ?? URLSession(configuration: .default)
        session.resumedDataTask(with: request) { [weak self] (data: Data?, respose: URLResponse?, error: Error?) in
            guard
                let strongSelf = self,
                !strongSelf.isCancelled else { return }
            // If another request has happened in the meantime, this will be deallocated
            do {
                try strongSelf.parseData(data: data)
            } catch let err {
                self?.operationError = err
            }
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
    }

}

#if DEBUG
extension SearchOperation {
    func _setURLSession(_ session: URLSessionProtocol) {
        urlSession = session
    }
}
#endif
