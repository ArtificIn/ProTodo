//
//  ManagedProject+CoreDataProperties.swift
//  
//
//  Created by 성다연 on 2021/05/03.
//
//

import Foundation
import CoreData


extension ManagedProject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProject> {
        return NSFetchRequest<ManagedProject>(entityName: "ManagedProject")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var boardList: NSSet?

}

// MARK: Generated accessors for boardList
extension ManagedProject {

    @objc(addBoardListObject:)
    @NSManaged public func addToBoardList(_ value: ManagedProjectBoard)

    @objc(removeBoardListObject:)
    @NSManaged public func removeFromBoardList(_ value: ManagedProjectBoard)

    @objc(addBoardList:)
    @NSManaged public func addToBoardList(_ values: NSSet)

    @objc(removeBoardList:)
    @NSManaged public func removeFromBoardList(_ values: NSSet)

}
