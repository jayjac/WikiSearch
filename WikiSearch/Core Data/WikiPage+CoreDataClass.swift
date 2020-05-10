//
//  WikiPage+CoreDataClass.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/8/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//
//

import Foundation
import CoreData


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
//@NSManaged public var pageid: Int64
//@NSManaged public var title: String?
//@NSManaged public var fullURL: URL?
//@NSManaged public var touched: Date?


@objc(WikiPage)
public class WikiPage: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case pageid
        case fullurl
        case touched
        case pagelanguage
    }
    
    public convenience required init(from decoder: Decoder) throws {
        self.init(context: CoreDataStack.shared.context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        fullURL = try? values.decode(URL.self, forKey: .fullurl)
        let timestamp = try values.decode(String.self, forKey: .touched)
        lastRevision = DatesManager.date(from: timestamp)
        saveDate = Date()
        language = try values.decode(String.self, forKey: .pagelanguage)
    }

}
