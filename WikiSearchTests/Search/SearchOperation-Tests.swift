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
        
        func resumedDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
            dataTaskCalled = true
            completionHandler(nil, nil, nil)
        }
        
        
        
        
    }

    func test_No_server_Call_because_operation_cancelled() throws {
        let mockSession = MockURLSession()
        XCTAssertEqual(mockSession.dataTaskCalled, false)
        let searchOperation = SearchOperation(searchText: "", page: 222, type: .snippet)
        searchOperation._setURLSession(mockSession)
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1 // To make sure I can add and cancel the queue before the next op gets processed
        queue.addOperation {
            Thread.sleep(forTimeInterval: 0.2) // Small wait so the next operation can be added and canceled
        }
        queue.addOperation(searchOperation)
        queue.cancelAllOperations()
        queue.waitUntilAllOperationsAreFinished()
        XCTAssertEqual(mockSession.dataTaskCalled, false)
    }



}
