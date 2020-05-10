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
struct SnippetAPIResponse: Codable {
    let query: SnippetQueryFieldResponse
}

struct SnippetQueryFieldResponse: Codable {
    let search: [SnippetSearchResult]
}

struct SnippetSearchResult: Codable {
    
    //let title: String
    let pageid: Int
    let snippet: String
    //let timestamp: String
    
}


extension SnippetSearchResult {
    
    var snippetHTML: String {
        return """
        <!doctype html>
        <html>
        <head>
        <style>
        :root { color-scheme: light dark; }
        body { font-size: 20pt; font-family: "Arial", sans-serif; }
        .searchmatch { font-weight: 800; }
        </style>
        </head>
        <body>
        \(self.snippet)
        </body>
        </html>
        """
    }
}
