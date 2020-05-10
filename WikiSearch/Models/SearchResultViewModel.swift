//
//  SearchResultViewModel.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation

protocol SearchResultViewModelDelegate: class {
    func openSearchResultURL(url: URL)
}


class SearchResultViewModel {
    
    private let result: SearchResultProtocol
    private weak var delegate: SearchResultViewModelDelegate?
    
    init(result: SearchResultProtocol,
         delegate: SearchResultViewModelDelegate?) {
        self.result = result
        self.delegate = delegate
    }
    
    
    var title: String {
        return result.title ?? ""
    }
    
    var snippetHTML: String? {
        //TODO: do the HTML
        return result.snippet
    }
    
    var lastEditHumanReadableTime: String {
        return ""
    }
    
    func openURL() {
        guard
            let url = result.fullURL,
            let delegate = delegate else { return }
        delegate.openSearchResultURL(url: url)
    }
 

}
