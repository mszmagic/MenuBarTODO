//
//  StorageHelper.swift
//  MenuBarTODO
//
//  Created by Shunzhe Ma on R 3/01/21.
//

import Foundation
import CoreData

class StorageHelper {
    
    static let shared = StorageHelper()
    
    let storageContext: NSManagedObjectContext
    
    init() {
        let container = NSPersistentCloudKitContainer(name: "MenuBarTODO")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
        let context = container.viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        self.storageContext = context
    }
    
}
