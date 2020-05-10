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
    private(set) var searchResultArray: [SnippetSearchResult] = [SnippetSearchResult]()
    private(set) var pagesObjectIDS: [NSManagedObjectID] = [NSManagedObjectID]()
    private var urlSession: URLSessionProtocol?
    
    
    init(searchText: String,
         page: Int,
         type: SearchOperationType) {
        self.type = type
        self.page = page
        self.searchText = searchText
        let url = type == SearchOperationType.snippet ? SearchManager.generateSnippetSearchURL(page: page, for: searchText) : SearchManager.generateSnippetSearchURL(page: page, for: searchText)
        self.request = URLRequest(url: url)
    }
    
    private func parseData(data: Data?) {
        guard let data = data else { return }
        switch type {
        case .snippet:
            parseSnippetResponse(data: data)
            
        case .url:
            pagesObjectIDS = CoreDataStack.shared.parseURLResponse(data: data)
        }
    }


    private func parseSnippetResponse(data: Data) {
        guard let apiResponse = try? JSONDecoder().decode(SnippetAPIResponse.self, from: data) else { return }
        searchResultArray = apiResponse.query.search
    }
    
    override func main() {
        if isCancelled {
            return
        }
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let session = urlSession ?? URLSession(configuration: .default)
        session.dataTask(with: request) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard
                let strongSelf = self,
                !strongSelf.isCancelled else { return } // If another request has come in, this will be deallocated
            strongSelf.parseData(data: data)
            dispatchGroup.leave()
        }.resume()
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
