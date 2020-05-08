//
//  WikiSearchTests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/2/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch

class WikiSearchTests: XCTestCase {


    func generateSearchURL(for query: String) -> URL {
        guard var urlComponents = URLComponents(string: Constants.wikipediaBaseURLString) else { fatalError() }
        let actionQI = URLQueryItem(name: "action", value: "query")
        let listQI = URLQueryItem(name: "list", value: "search")
        let limitQI = URLQueryItem(name: "srlimit", value: "10")
        let formatQI = URLQueryItem(name: "format", value: "json")
        let searchQI = URLQueryItem(name: "srsearch", value: query)
        urlComponents.queryItems = [actionQI, limitQI, formatQI, listQI, searchQI]
        return urlComponents.url!
    }

    func test_API() throws {

        let expect = XCTestExpectation()
        let request = URLRequest(url: generateSearchURL(for: "nelson"))
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard let strongSelf = self else { return } // If another request has come in, this will be deallocated
            guard let data = data, let response = response else { return }
            print("*****")
//            let responseString = String(data: data, encoding: .utf8)
//            print(responseString)
            do {
                let apiResponse = try JSONDecoder().decode(SearchAPIResponse.self, from: data)
                print(apiResponse)
            } catch let err {
                print(err)
            }
            expect.fulfill()
        }
        task.resume()
        wait(for: [expect], timeout: 20.0)
    }



}
