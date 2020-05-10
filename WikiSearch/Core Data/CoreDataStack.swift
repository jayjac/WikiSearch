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
//    self.init(context: CoreDataStack.shared.context)
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    title = try values.decode(String.self, forKey: .title)
//    //snippet = try values.decode(String.self, forKey: .snippet)
//    //url = try? values.decode(URL.self, forKey: .url)
//    timestamp = try values.decode(String.self, forKey: .timestamp)
//}

import CoreData


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
                          completionClosure: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        if shared == nil {
            shared = CoreDataStack(container: container, completionClosure: completionClosure)
        }
        #if DEBUG
        shared.persistentContainer = container
        #endif
    }
    
    private init(container: NSPersistentContainer = NSPersistentContainer(name: "WikiSearch"), completionClosure: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        self.persistentContainer = container
        persistentContainer.loadPersistentStores(completionHandler: completionClosure)
    }
    
    
    func parseURLResponse(data: Data) -> [NSManagedObjectID] {
        var objectIDS = [NSManagedObjectID]()
        let context = CoreDataStack.shared.persistentContainer.newBackgroundContext()
        context.performAndWait {
            guard let apiResponse = try? JSONDecoder().decode(URLAPIResponse.self, from: data) else { return }
            apiResponse.query.search.forEach { (page) in
//                page.saveDate = Date()
//                objectIDS.append(page.objectID)
            }
        }
       do {
            if context.hasChanges {
                try context.save()
            }
       } catch {}
        return objectIDS
    }
    
    
}


#if DEBUG
extension CoreDataStack {
    class func reset() {
        shared = nil
    }
}
#endif
