//
//  SearchOperation-Tests.swift
//  WikiSearchTests
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import WikiSearch


class SearchOperation_Tests: XCTestCase {
    
    class MockURLSession: URLSessionProtocol {
        private(set) var dataTaskCalled: Bool = false
        
        func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            dataTaskCalled = true
            completionHandler(nil, nil, nil)
            return URLSession(configuration: .ephemeral).dataTask(with: URL(string: "bla")!)
        }
        
        
    }

    func test_No_server_Call_because_operation_cancelled() throws {
        let mockSession = MockURLSession()
        XCTAssertEqual(mockSession.dataTaskCalled, false)
        let searchOperation = SearchOperation(searchText: "", page: 222)
        searchOperation._setURLSession(mockSession)
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1 // To make sure I can add and cancel the next operation
        queue.addOperation {
            Thread.sleep(forTimeInterval: 0.2) // Small wait so the next operation can be added and interrupted
        }
        queue.addOperation(searchOperation)
        searchOperation.cancel()
        queue.waitUntilAllOperationsAreFinished()
        XCTAssertEqual(mockSession.dataTaskCalled, false)
    }



}
