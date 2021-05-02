//
//  ManagedProject+CoreDataProperties.swift
//  
//
//  Created by 성다연 on 2021/05/02.
//
//

import Foundation
import CoreData


extension ManagedProject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProject> {
        return NSFetchRequest<ManagedProject>(entityName: "ManagedProject")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var list: [ManagedProjectBoard]?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?

}

extension ManagedProject : Identifiable {
    
}
