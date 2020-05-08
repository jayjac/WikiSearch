//
//  SearchOperation.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation

/*
 * Fetches one page of 500 results from WikiPedia
 */
class SearchOperation: Operation {
    
    private let page: Int
    private let searchText: String
    private(set) var searchResultArray: [SearchResult] = [SearchResult]()
    
    
    init(searchText: String, page: Int) {
        self.page = page
        self.searchText = searchText
    }
    
    
    func parseResponse(data: Data?) {
        guard let data = data else { return }
        guard let apiResponse = try? JSONDecoder().decode(SearchAPIResponse.self, from: data) else { return }
        searchResultArray = apiResponse.query.search
    }
    
    override func main() {
        if isCancelled {
            return
        }
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let request = URLRequest(url: SearchManager.generateSearchURL(page: page, for: searchText))
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard
                let strongSelf = self,
                !strongSelf.isCancelled else { return } // If another request has come in, this will be deallocated
            strongSelf.parseResponse(data: data)
            dispatchGroup.leave()
        }.resume()
        dispatchGroup.wait()
    }
    
    
}
