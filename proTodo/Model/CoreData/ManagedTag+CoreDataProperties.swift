//
//  ManagedTag+CoreDataProperties.swift
//  
//
//  Created by 성다연 on 2021/05/05.
//
//

import Foundation
import CoreData


extension ManagedTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedTag> {
        return NSFetchRequest<ManagedTag>(entityName: "ManagedTag")
    }

    @NSManaged public var color: Int32
    @NSManaged public var name: String?
    @NSManaged public var id: Int32
    @NSManaged public var todo: ManagedTodo?
}
