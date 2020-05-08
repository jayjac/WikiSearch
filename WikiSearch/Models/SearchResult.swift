//
//  SearchResult.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation

/*
 * WikiPedia responds with a JSON object:
 * batchcomplete: string,
 * query: { searchinfo: Object, search: Array<SearchResult> }
 */
struct SearchAPIResponse: Codable {
    let query: QueryFieldResponse
}

struct QueryFieldResponse: Codable {
    let search: [SearchResult]
}

struct SearchResult: Codable {
    
    let title: String
    let pageid: Int
    let snippet: String
    let timestamp: String
    
}


extension SearchResult {
    
    var snippetHTML: String {
        return """
        <!doctype html>
        <html>
        <head>
        <style>
        body { font-size: 18pt; font-family: "Arial", sans-serif; }
        .searchmatch { background-color: yellow; }
        </style>
        </head>
        <body>
        \(self.snippet)
        </body>
        </html>
        """
    }
}
