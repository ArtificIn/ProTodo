//
//  project.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/16.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation

enum Category : String {
    case todoList
    case doingList
    case doneList
}

struct Project {
    let id : Int
    var name : String
    var endDate : Date
    var alert : Int
    var category : [Category : Todo]
}

class ProjectModel {
    static let shared = ProjectModel()
    var projectList : [Project]
    
    init() {
        projectList = []
    }
    
    init(list : [Project]) {
        projectList = list
    }
}
