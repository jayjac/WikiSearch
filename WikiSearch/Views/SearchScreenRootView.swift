//
//  SearchScreenRootView.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/9/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit

class SearchScreenRootView: UIView {
    
    let tableView: UITableView
    let searchBar: UISearchBar
    
    required init?(coder: NSCoder) {
        fatalError("Should not be called from IB")
    }
    
    init() {
        tableView = UITableView()
        searchBar = UISearchBar()
        super.init(frame: .zero)
        setupUI()
    }
    
    
    func setupUI() {
        backgroundColor = UIColor.systemBackground
        addSearchBar()
        addTableView()
    }
    
    private func addSearchBar() {
        addSubview(searchBar)
        searchBar.placeholder = NSLocalizedString("Search WikiPedia", comment: "Placeholder") //"Search WikiPedia"
        searchBar.accessibilityIdentifier = "WikiSearchBar"
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.prompt = NSLocalizedString("WikiSearch", comment: "Search title") //"Search on WikiPedia"
    }
    
    private func addTableView() {
        tableView.registerCellType(SearchTableViewCell.self)
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.accessibilityIdentifier = "ResultsTableView"
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.keyboardDismissMode = .onDrag
    }
    


}
