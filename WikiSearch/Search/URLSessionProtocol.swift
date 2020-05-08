//
//  URLSessionProtocol.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation


protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
