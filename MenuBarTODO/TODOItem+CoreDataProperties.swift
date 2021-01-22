//
//  TODOItem+CoreDataProperties.swift
//  MenuBarTODO
//
//  Created by Shunzhe Ma on R 3/01/21.
//
//

import Foundation
import CoreData


extension TODOItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TODOItem> {
        return NSFetchRequest<TODOItem>(entityName: "TODOItem")
    }

    @NSManaged public var itemID: String?
    @NSManaged public var itemContent: String?
    @NSManaged public var itemIsCompleted: Bool
    @NSManaged public var addedDate: Date?

}

extension TODOItem : Identifiable {

}
