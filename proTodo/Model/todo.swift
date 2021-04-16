//
//  todoData.swift
//  proTodo
//
//  Created by 성다연 on 30/09/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import Foundation

let TodoFileName = "ProTodoList.file"
let projectName = "ProTodo"

struct Todo {
    let id : Int
    var name : String
    var color : Int
    var startDate : String
    var endDate : String
    var isRepeating : Int?
    var label : [Tag]
}

struct Tag {
    let id : Int
    var name : String
    var color : Int
}


class TodoModel {
    static let shared = TodoModel()
    var arrayList : [Todo] = [] // 일반 저장
    
    func defaultData() -> Array<Todo>{
        let stock = Todo(id: 0, name: "앱 업데이트", color: 0xafeeee, startDate: "2021.10.11", endDate: "2021.10.11", label: [])
        let stock2 = Todo(id: 1, name: "쇼핑하기", color: 0xffbe46, startDate: "2021.10.12", endDate: "2021.10.12", label: [])
        let stock3 = Todo(id: 2, name: "운동하기", color: 0x34de53, startDate: "2021.10.13", endDate: "2021.10.13", label: [])
        return [stock, stock2, stock3]
    }
    
    init() {
        arrayList = defaultData()
    }
}


