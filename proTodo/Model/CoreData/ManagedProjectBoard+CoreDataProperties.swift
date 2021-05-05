//
//  ManagedProjectBoard+CoreDataProperties.swift
//  
//
//  Created by 성다연 on 2021/05/05.
//
//

import Foundation
import CoreData


extension ManagedProjectBoard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProjectBoard> {
        return NSFetchRequest<ManagedProjectBoard>(entityName: "ManagedProjectBoard")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int32
    @NSManaged public var project: ManagedProject?
    @NSManaged public var todo: Set<ManagedTodo>?

}

// MARK: Generated accessors for todo
extension ManagedProjectBoard {

    @objc(addTodoObject:)
    @NSManaged public func addToTodo(_ value: ManagedTodo)

    @objc(removeTodoObject:)
    @NSManaged public func removeFromTodo(_ value: ManagedTodo)

    @objc(addTodo:)
    @NSManaged public func addToTodo(_ values: NSSet)

    @objc(removeTodo:)
    @NSManaged public func removeFromTodo(_ values: NSSet)

}
