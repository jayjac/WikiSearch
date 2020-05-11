//
//  Constants.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation


struct Constants {
    
    
    static let wikipediaBaseURLString: String = "https://en.wikipedia.org/w/api.php"
    
    static func wikipediaSearchBaseURL(language: String) -> String  {
        return "https://\(language).wikipedia.org/w/api.php"
    }
    
    static let resultsCount: Int = 100
    
    private init() {}
}
