//
//  ManagedTodo+CoreDataProperties.swift
//  
//
//  Created by 성다연 on 2021/05/03.
//
//

import Foundation
import CoreData
import MobileCoreServices


extension ManagedTodo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedTodo> {
        return NSFetchRequest<ManagedTodo>(entityName: "ManagedTodo")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var id: Int32
    @NSManaged public var isRepeating: Int32
    @NSManaged public var name: String
    @NSManaged public var startDate: Date
    @NSManaged public var board: ManagedProjectBoard?
    @NSManaged public var tag: Set<ManagedTag>?
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

extension ManagedTodo {
    func toTodo() -> Todo {
        var tags : [Tag] = []
        if let t = tag {
            t.forEach { item in
                let i = item.toTag()
                tags.append(i)
            }
        }
        let todo = Todo.init(id: Int(id), name: name, startDate: startDate, endDate: endDate, isRepeating: Int(isRepeating), label: tags)
        return todo
    }
    
    func fromTodo(_ todo: Todo, context : NSManagedObjectContext) -> ManagedTodo{
        self.id = Int32(todo.id)
        self.name = todo.name
        self.startDate = todo.startDate
        self.endDate = todo.endDate
        self.isRepeating = Int32(todo.isRepeating ?? 0)
        
        var tags : Set<ManagedTag> = []
        for i in todo.label {
            tags.update(with: ManagedTag(context: context).fromTag(i))
        }
        self.tag = tags
        
        return self
    }
}
