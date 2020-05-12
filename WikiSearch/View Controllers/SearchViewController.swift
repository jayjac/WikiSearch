//
//  SearchViewController.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let rootView: SearchScreenRootView = SearchScreenRootView()
    private(set) lazy var searchBar = self.rootView.searchBar
    private(set) lazy var  tableView = self.rootView.tableView
    private lazy var searchManager: SearchManager = {
        let manager = SearchManager(delegate: self)
        return manager
    }()
    private(set) lazy var dataSource: SearchTableViewDataSource = SearchTableViewDataSource()
    weak var searchResultDelegate: SearchResultViewModelDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = rootView
        searchBar.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        setup_UITest()
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        tableView.reloadData()
        searchManager.search(for: text)
    }
    
}

extension SearchViewController: SearchManagerDelegate {
    func searchManagerDidFindResults(_ results: [SearchResultProtocol]) {
        let viewModels = results.map {
            SearchResultViewModel(result: $0, delegate: self.searchResultDelegate)
        }
        dataSource.updateResults(viewModels)
        tableView.reloadData()
    }
    
    func searchManagerDidFail(with error: Error) {
        print(error)
    }
}


extension SearchViewController {
    
    func setup_UITest() {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("UITEST-MOCK-RESULTS") {
            struct MockSearchResultProtocol: SearchResultProtocol {
                var title: String?
                var snippet: String?
                var fullURL: URL?
                var lastRevision: Date?
            }
            let mock = MockSearchResultProtocol(title: "Apple", snippet: "Some snippet", fullURL: URL(string: "https://google.com"), lastRevision: nil)
            let results: [SearchResultProtocol] = [SearchResultProtocol](repeatElement(mock, count: 50))
            let viewModels = results.map {
                SearchResultViewModel(result: $0, delegate: self.searchResultDelegate)
            }
            dataSource.updateResults(viewModels)
            tableView.reloadData()
        }
        #endif
    }
}



