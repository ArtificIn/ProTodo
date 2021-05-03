//
//  ManagedTodo+CoreDataProperties.swift
//  
//
//  Created by 성다연 on 2021/05/03.
//
//

import Foundation
import CoreData


extension ManagedTodo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedTodo> {
        return NSFetchRequest<ManagedTodo>(entityName: "ManagedTodo")
    }

    @NSManaged public var color: Int32
    @NSManaged public var endDate: Date?
    @NSManaged public var id: Int16
    @NSManaged public var isRepeating: Int32
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var board: ManagedProjectBoard?
    @NSManaged public var tag: NSSet?

}

// MARK: Generated accessors for tag
extension ManagedTodo {

    @objc(addTagObject:)
    @NSManaged public func addToTag(_ value: ManagedTag)

    @objc(removeTagObject:)
    @NSManaged public func removeFromTag(_ value: ManagedTag)

    @objc(addTag:)
    @NSManaged public func addToTag(_ values: NSSet)

    @objc(removeTag:)
    @NSManaged public func removeFromTag(_ values: NSSet)

}
