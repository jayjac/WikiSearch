//
//  SearchViewController.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    lazy var layoutManager: MainLayoutManager = {
        let layout = MainLayoutManager(rootView: self.view, tableView: self.tableView, searchBar: self.searchBar)
        return layout
    }()
    
    lazy var searchManager: SearchManager = {
        let manager = SearchManager(delegate: self)
        return manager
    }()
    
    lazy var dataSource: SearchTableViewDataSource = {
        let source = SearchTableViewDataSource(searchManager: self.searchManager)
        return source
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutManager.setupUI()
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
        searchManager.clearAllResults()
        tableView.reloadData()
        searchManager.search(for: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel clicked")
    }
    
}

extension SearchViewController: SearchManagerDelegate {
    func searchManagerDidFindResults() {
        tableView.reloadData()
    }
}


