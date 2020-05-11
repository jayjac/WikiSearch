//
//  SearchTableViewDataSource.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit

class SearchTableViewDataSource: NSObject {
    
    private var viewModels: [SearchResultViewModel] = [SearchResultViewModel]()
    

    
    func updateResults(_ resultsArray: [SearchResultViewModel]) {
        viewModels = resultsArray
    }
    
}



extension SearchTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellType(SearchTableViewCell.self)
        let row = indexPath.row
        let result = viewModels[row]
        cell.setup(with: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
}

extension SearchTableViewDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vm = viewModels[indexPath.row]
        vm.openURL()
    }
}
