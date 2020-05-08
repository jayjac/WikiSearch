//
//  LayoutManager.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit

class MainLayoutManager {
    
    private let searchBar: UISearchBar
    private let tableView: UITableView
    private let view: UIView
    
    init(rootView: UIView, tableView: UITableView, searchBar: UISearchBar) {
        self.view = rootView
        self.tableView = tableView
        self.searchBar = searchBar
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        addSearchBar()
        addTableView()
    }
    
    private func addSearchBar() {
        view.addSubview(searchBar)
        searchBar.placeholder = "Search WikiPedia"
        searchBar.accessibilityIdentifier = "WikiSearchBar"
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.prompt = "Search on WikiPedia"
    }
    
    private func addTableView() {
        
        tableView.registerCellType(SearchTableViewCell.self)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.accessibilityIdentifier = "ResultsTableView"
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.keyboardDismissMode = .onDrag
    }
}
