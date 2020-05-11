//
//  SearchResultProtocol.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/9/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation

protocol SearchResultProtocol {
    var title: String? { get }
    var snippet: String? { get }
    var fullURL: URL? { get }
    var lastRevision: Date? { get }
}

extension WikiPage: SearchResultProtocol {}
