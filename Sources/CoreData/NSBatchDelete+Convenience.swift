//
//  NSBatchDelete+Convenience.swift
//  Extensions
//
//  Created by David Lensky on 18/09/2018.
//

import CoreData
import Foundation

/* NOTE: When implementing NSBatchDeleteRequest, watch out for NSBatchDeleteResult and NSDeletedObjectsKey
    - Apple documentation contains example with NSBatchUpdateResult and NSUpdatedObjectsKey which will not work!

    TODO: Refactor and replace with merging algorithm
 */

extension NSBatchDeleteResult {

    var deletedObjectIds: [String: [NSManagedObjectID]]? {
        guard let ids = self.result as? [NSManagedObjectID] else { return nil }
        return [NSDeletedObjectsKey: ids]
    }

}

extension NSManagedObjectContext {

    func execute(_ request: NSBatchDeleteRequest) throws -> NSBatchDeleteResult? {
        return (try? self.execute(request as NSPersistentStoreRequest)) as? NSBatchDeleteResult
    }

}
