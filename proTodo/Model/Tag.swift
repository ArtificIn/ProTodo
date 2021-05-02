//
//  Tag.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/17.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation
import CoreData

struct Tag: Equatable {
    var id : Int
    var name : String
    var color : Int
    var objectID : NSManagedObjectID?
    
    init(id: Int = 0, name: String, color : Int) {
        self.id = id
        self.name = name
        self.color = color
    }
}

func ==(lhs: Tag, rhs: Tag) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
}

struct Tag2 : Equatable, Hashable, Identifiable, Codable {
    let id : Int
    var name : String
    var color : Int
}

class TagModel {
    static let shared = TagModel()
    var tagList : [Tag2] = []
    
    init() {
        tagList = defaultData()
    }
    
    private func defaultData() -> [Tag2] {
        let t1 = Tag2(id: 0, name: "Study", color: 0xFF9E67)
        let t2 = Tag2(id: 1, name: "Exercise", color: 0x6D84FD)
        return [t1, t2]
    }
}
