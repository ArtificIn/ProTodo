//
//  ManagedProjectBoard+CoreDataProperties.swift
//  
//
//  Created by 성다연 on 2021/05/03.
//
//

import Foundation
import CoreData


extension ManagedProjectBoard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProjectBoard> {
        return NSFetchRequest<ManagedProjectBoard>(entityName: "ManagedProjectBoard")
    }

    @NSManaged public var id: Int32
    @NSManaged public var category: String?
    @NSManaged public var todoList: NSSet?
    @NSManaged public var project: ManagedProject?

}

// MARK: Generated accessors for todoList
extension ManagedProjectBoard {

    @objc(addTodoListObject:)
    @NSManaged public func addToTodoList(_ value: ManagedTodo)

    @objc(removeTodoListObject:)
    @NSManaged public func removeFromTodoList(_ value: ManagedTodo)

    @objc(addTodoList:)
    @NSManaged public func addToTodoList(_ values: NSSet)

    @objc(removeTodoList:)
    @NSManaged public func removeFromTodoList(_ values: NSSet)

}
