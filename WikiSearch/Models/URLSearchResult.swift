//
//  URLSearchResult.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/9/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation

/*
 * WikiPedia responds with a JSON object:
 * batchcomplete: string,
 * query: { searchinfo: Object, search: { id: WiKIPage } }
 */
struct URLAPIResponse: Decodable {
    let query: URLQueryFieldResponse
}

struct URLQueryFieldResponse: Decodable {
    let pages: [String: WikiPage]
}


