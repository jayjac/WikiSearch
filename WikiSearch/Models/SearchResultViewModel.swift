//
//  SearchResultViewModel.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation


class SearchResultViewModel {
    
    private let searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
    
    var title: String {
        return searchResult.title
    }
    
    var lastEditTime: String {
        return ""
    }
}
