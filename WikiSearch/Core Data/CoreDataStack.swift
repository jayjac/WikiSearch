//
//  CoreDataStack.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

//enum CodingKeys: String, CodingKey {
//    case title
//    //case snippet
//    case url
//    case timestamp
//}
//
//
//public convenience required init(from decoder: Decoder) throws {
import CoreData

typealias CoreDataStackCompletionClosure = (NSPersistentStoreDescription, Error?) -> Void

class CoreDataStack {
    
    private var persistentContainer: NSPersistentContainer
    private(set) lazy var viewContext: NSManagedObjectContext = self.persistentContainer.viewContext
    private(set) lazy var backgroundContext: NSManagedObjectContext = self.persistentContainer.newBackgroundContext()
    
    private(set) static var shared: CoreDataStack!

    /*
     * Should only be called once, and with no container argument for release builds
     */
    class func initialize(
        container: NSPersistentContainer = NSPersistentContainer(name: "WikiSearch"),
        completionClosure: @escaping CoreDataStackCompletionClosure) {
        shared = CoreDataStack(container: container, completionClosure: completionClosure)
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
