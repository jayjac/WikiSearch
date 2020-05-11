//
//  UITableViewCell+ReuseIdentifier.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReuseIdentifiable {
    static var reuseIdentifier: String {
        let className = NSStringFromClass(Self.self)
        return className.components(separatedBy: ".").last!
    }
}

/*
 * Convenience to register cells with the class name as the reuse-identifier
 * Does not work with inner classes due to name-mangling
 */
extension UITableView {
    func registerCellType<T: UITableViewCell>(_ cell: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueCellType<T: UITableViewCell>(_ cell: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else { fatalError() }
        return cell
    }
}
