//
//  ProjectBoard.swift
//  proTodo
//
//  Created by 성다연 on 2021/05/02.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation
import CoreData

@objc enum Category : Int32 {
    case todoList = 0
    case doingList = 1
    case doneList = 2
    
    func name() -> String {
        switch self {
        case .todoList : return "Todo"
        case .doingList : return "Doing"
        case .doneList : return "Done"
        }
    }
}

public class ProjectBoard2 : NSObject, NSCoding {
    let id : Int
    let category : Category
    var list : [ManagedTodo]
    
    init(id: Int, category : Category, list: [ManagedTodo]) {
        self.id = id
        self.category = category
        self.list = list
    }
    
    init(with values: Dictionary<String, Any>) {
        id = Int(values["id"] as! String)!
        category = values["category"] as! Category
        list = values["list"] as! [ManagedTodo]
    }
    
    public required convenience init?(coder: NSCoder) {
        var boardValues = [String:Any]()
        boardValues["id"] = coder.decodeObject(forKey: "id") as! Int
        boardValues["category"] = coder.decodeObject(forKey: "category") as! Category
        boardValues["list"] = coder.decodeObject(forKey: "list") as! [ManagedTodo]
        self.init(with: boardValues)
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(String(self.id), forKey: "id")
        coder.encode(self.category, forKey: "category")
        coder.encode(self.list, forKey: "list")
    }
}
