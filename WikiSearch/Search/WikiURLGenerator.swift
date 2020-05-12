//
//  WikiURLGenerator.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/10/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation

struct WikiURLGenerator {
    
    //https://en.wikipedia.org/w/api.php?action=query&srlimit=500&sroffset=2&list=search&srsearch=Nelson%20Mandela&utf8=&format=json
    /*
     * This URL returns results with article snippets
     */
    static func generateSnippetSearchURL(page: Int,
                                  for query: String,
                                  language: String = Locale.preferredLanguages[0]) -> URL {
        guard var urlComponents = URLComponents(string: Constants.wikipediaSearchBaseURL(language: language)) else { fatalError() }
        let actionQI = URLQueryItem(name: "action", value: "query")
        let offsetQI = URLQueryItem(name: "sroffset", value: page.toString)
        let listQI = URLQueryItem(name: "list", value: "search")
        let limitQI = URLQueryItem(name: "srlimit", value: Constants.resultsCount.toString)
        let formatQI = URLQueryItem(name: "format", value: "json")
        let searchQI = URLQueryItem(name: "srsearch", value: query)
        urlComponents.queryItems = [actionQI, offsetQI, limitQI, formatQI, listQI, searchQI]
        return urlComponents.url!
    }
    
    
    
    //https://en.wikipedia.org/w/api.php?action=query&generator=search&gsrsearch=Nelson%20Mandela&format=json&prop=info&inprop=url&gsrlimit=20
    /*
     * This page returns article fullurl and touched parameters
     */
    static func generateURLSearchURL(page: Int,
                                     query: String,
                                     language: String = Locale.preferredLanguages[0]) -> URL {
        guard var urlComponents = URLComponents(string: Constants.wikipediaSearchBaseURL(language: language)) else { fatalError() }
        
        let actionQI = URLQueryItem(name: "action", value: "query")
        let generatorQI = URLQueryItem(name: "generator", value: "search")
        let searchQI = URLQueryItem(name: "gsrsearch", value: query)
        let offsetQI = URLQueryItem(name: "sroffset", value: page.toString)
        let limitQI = URLQueryItem(name: "gsrlimit", value: Constants.resultsCount.toString)
        let formatQI = URLQueryItem(name: "format", value: "json")
        let infoQI = URLQueryItem(name: "prop", value: "info")
        let urlQI = URLQueryItem(name: "inprop", value: "url")
        urlComponents.queryItems = [actionQI, generatorQI, searchQI, offsetQI, limitQI, formatQI, infoQI, urlQI]
        return urlComponents.url!
    }
    
}
