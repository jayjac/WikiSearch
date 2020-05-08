//
//  WikiPage+CoreDataProperties.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/8/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//
//

import Foundation
import CoreData


extension WikiPage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WikiPage> {
        return NSFetchRequest<WikiPage>(entityName: "WikiPage")
    }

    @NSManaged public var timestamp: String?
    @NSManaged public var pageid: Int64
    @NSManaged public var snippet: String?
    @NSManaged public var title: String?
    @NSManaged public var url: URL?

}
