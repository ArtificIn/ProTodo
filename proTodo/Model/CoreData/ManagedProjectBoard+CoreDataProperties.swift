//
//  ManagedProjectBoard+CoreDataProperties.swift
//  
//
//  Created by 성다연 on 2021/05/02.
//
//

import Foundation
import CoreData


extension ManagedProjectBoard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProjectBoard> {
        return NSFetchRequest<ManagedProjectBoard>(entityName: "ManagedProjectBoard")
    }

    @NSManaged public var id: Int32
    @NSManaged public var category: String
    @NSManaged public var todoList: [ManagedTodo]?

}
