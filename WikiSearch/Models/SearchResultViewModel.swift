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
    
    var snippetHTML: String {
        guard let snippet = result.snippet else {
            return ""
        }
        return """
        <!doctype html>
        <html>
        <head>
        <style>
        :root { color-scheme: light dark; }
        html, body { background-color: transparent; }
        body { font-size: 20pt; font-family: "Arial", sans-serif; }
        .searchmatch { font-weight: 800; }
        </style>
        </head>
        <body>
        \(snippet)
        </body>
        </html>
        """
    }
    var lastEditHumanReadableTime: String {
        guard let date = result.lastRevision else {
            return ""
        }
        return DatesManager.humanReadableDateString(from: date)
    }
    
    func openURL() {
        guard
            let url = result.fullURL,
            let delegate = delegate else { return }
        delegate.openSearchResultURL(url: url)
    }
 

}
