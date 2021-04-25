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
    
    func getCount() -> Int {
        switch self {
        case .todoList:
            return 0
        case .doingList:
            return 1
        case .doneList:
            return 2
        default:
            break
        }
    }
}

struct ProjectBoard : Identifiable {
    let id : Int
    var category : Category
    var todoList : [Todo]
}

struct Project {
    var name : String
    var startDate : Date
    var endDate : Date?
    var list : [ProjectBoard] = []
}

class ProjectModel {
    static let shared = ProjectModel()
    var list : [Project] = []
    
    init() {
        list = defaultData()
    }
    
    init(list : [Project]) {
        self.list = list
    }
    
    private func defaultData() -> [Project] {
        let project = Project(name: "기말고사", startDate: Date() - (86400 * 3), endDate: Date() + (86400 * 12),list: projectDefaultData())
        return [project]
    }
    
    private func projectDefaultData() -> [ProjectBoard] {
        let p1 = ProjectBoard(id: 0, category: .todoList, todoList: TodoModel.shared.defaultData())
        let p2 = ProjectBoard(id: 1, category: .doneList, todoList: [])
        let p3 = ProjectBoard(id: 2, category: .doneList, todoList: [])
        
        return [p1, p2, p3]
    }
}

