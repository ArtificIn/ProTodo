//
//  Tag.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/17.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation

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
