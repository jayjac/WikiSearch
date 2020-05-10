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
    private lazy var dataSource: SearchTableViewDataSource = SearchTableViewDataSource()
    weak var searchResultDelegate: SearchResultViewModelDelegate?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = rootView
        searchBar.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
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
    }
}


