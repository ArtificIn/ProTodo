//
//  project.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/16.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation


struct Project2 {
    var name : String
    var startDate : Date
    var endDate : Date?
    var list : [ProjectBoard2] = []
}

class ProjectModel {
    static let shared = ProjectModel()
    var list : [Project2] = []
    
    init() {
        list = defaultData()
    }
    
    init(list : [Project2]) {
        self.list = list
    }
    
    private func defaultData() -> [Project2] {
        let project = Project2(name: "기말고사", startDate: Date() - (86400 * 3), endDate: Date() + (86400 * 12),list: [])
        return [project]
    }
    
//    func projectDefaultData() -> [ProjectBoard] {
//        let p1 = ProjectBoard(id: 0, category: .todoList, todoList: TodoModel.shared.defaultData())
//        let p2 = ProjectBoard(id: 1, category: .doingList, todoList: [])
//        let p3 = ProjectBoard(id: 2, category: .doneList, todoList: [])
//
//        return [p1, p2, p3]
//    }
}

