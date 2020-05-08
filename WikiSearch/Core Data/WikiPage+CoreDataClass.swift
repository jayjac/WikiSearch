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

@objc(WikiPage)
public class WikiPage: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case snippet
        case url
        case timestamp
    }
    
    
    public convenience required init(from decoder: Decoder) throws {
        self.init(context: CoreDataStack.shared.context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        snippet = try values.decode(String.self, forKey: .snippet)
        //url = try? values.decode(URL.self, forKey: .url)
        timestamp = try values.decode(String.self, forKey: .timestamp)
    }

}
