//
//  CoreDataStack.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import CoreData


class CoreDataStack {
    
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var shared: CoreDataStack!

    /*
     * Should only be called once, and with no container argument for release builds
     */
    class func initialize(
        container: NSPersistentContainer = NSPersistentContainer(name: "WikiSearch"),
                          completionClosure: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        if shared == nil {
            shared = CoreDataStack(container: container, completionClosure: completionClosure)
        }
    }
    
    private init(container: NSPersistentContainer = NSPersistentContainer(name: "WikiSearch"), completionClosure: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        self.persistentContainer = container
        persistentContainer.loadPersistentStores(completionHandler: completionClosure)
    }
    
    
}


#if DEBUG
extension CoreDataStack {
    class func reset() {
        shared = nil
    }
}
#endif
