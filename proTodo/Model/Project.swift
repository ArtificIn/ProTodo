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

struct Project : Identifiable {
    let id : Int
    var name : String
    var endDate : String
    var alert : Int?
    var category : [Category : Todo]
}

class ProjectModel {
    static let shared = ProjectModel()
    var projectList : [Project] = []
    
    init() {
        projectList = defaultData()
    }
    
    init(list : [Project]) {
        projectList = list
    }
    
    private func defaultData() -> [Project] {
        let p1 = Project(id: 0, name: "기말고사", endDate: "2021.11.11", category: [:])
        let p2 = Project(id: 1, name: "앱 개발하기", endDate: "2021.06.20", alert: nil, category: [:])
        
        return [p1, p2]
    }
}
