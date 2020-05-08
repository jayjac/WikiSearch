//
//  SearchTableViewCell.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import WebKit

class SearchTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = UILabel()
    private let snippetWebView = WKWebView()

    override func setSelected(_ selected: Bool, animated: Bool) {}
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    private func setupUI() {
        addTitleLabel()
        addWebView()
    }
    
    private func addTitleLabel() {
        titleLabel.numberOfLines = 4
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5.0),
            contentView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -5.0),
            contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5.0),
        ])
    }
    
    private func addWebView() {
        snippetWebView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(snippetWebView)
        NSLayoutConstraint.activate([
            snippetWebView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: snippetWebView.leadingAnchor, constant: -5.0),
            contentView.trailingAnchor.constraint(equalTo: snippetWebView.trailingAnchor, constant: 5.0),
            contentView.bottomAnchor.constraint(equalTo: snippetWebView.bottomAnchor, constant: 5.0),
            snippetWebView.heightAnchor.constraint(equalToConstant: 60.0)
        ])
    }
    
    
    func setup(with searchResult: SearchResult) {
        titleLabel.text = searchResult.title
        snippetWebView.loadHTMLString(searchResult.snippetHTML, baseURL: nil)
    }

}
