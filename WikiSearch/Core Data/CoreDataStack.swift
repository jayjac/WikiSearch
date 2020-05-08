//
//  CoreDataStack.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import CoreData


class CoreDataStack {
    

    private let persistentContainer: NSPersistentContainer
    
    init(container: NSPersistentContainer = NSPersistentContainer(name: "WikiSearch")) {

        self.persistentContainer = container
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            //completionClosure()
        }
    }
    
    
}
