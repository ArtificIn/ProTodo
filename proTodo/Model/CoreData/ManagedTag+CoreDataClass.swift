//
//  ManagedTag+CoreDataClass.swift
//  
//
//  Created by 성다연 on 2021/05/05.
//
//

import Foundation
import CoreData

@objc(ManagedTag)
public class ManagedTag: NSManagedObject {
    func toTag() -> Tag {
        let tag = Tag(id: Int(id), name: name!, color: Int(color))
        return tag
    }
    
    func fromTag(_ tag: Tag) -> ManagedTag{
        self.id = Int32(tag.id)
        self.name = tag.name
        self.color = Int32(tag.color)
        return self
    }
}
