//
//  ManagedTodo+CoreDataProperties.swift
//  
//
//  Created by 성다연 on 2021/05/02.
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
    @NSManaged public var tag: [ManagedTag]?

}
