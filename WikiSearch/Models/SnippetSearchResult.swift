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
    
    static func parseSnippetResponse(data: Data) -> SnippetAPIResponse? {
        return try? JSONDecoder().decode(SnippetAPIResponse.self, from: data)
    }
}

struct SnippetQueryFieldResponse: Codable {
    let search: [SnippetSearchResult]
}

struct SnippetSearchResult: Codable {
    let pageid: Int
    let snippet: String
}



