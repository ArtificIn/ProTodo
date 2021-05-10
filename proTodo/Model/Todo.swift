//
//  todoData.swift
//  proTodo
//
//  Created by 성다연 on 30/09/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import Foundation
import MobileCoreServices

final class Todo : NSObject {
    var id : Int
    var name : String
    var startDate : Date
    var endDate : Date?
    var isRepeating : Int?
    var label : [Tag]
    
    init(id: Int, name: String, startDate : Date, endDate: Date?, isRepeating : Int?, label : [Tag]) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isRepeating = isRepeating
        self.label = label
    }
}

final class TodoModel {
    static let shared = TodoModel()
    var list : [Todo] = [] // 일반 저장
    
    func defaultData() -> [Todo] {
        let stock = Todo(id: 0, name: "앱 업데이트", startDate: Date(), endDate: Date() + 3 * 86400, isRepeating: nil, label: [])
        let stock2 = Todo(id: 1, name: "쇼핑하기", startDate: Date() - 86400, endDate: Date() + 7 * 86400, isRepeating: nil, label: [])
        let stock3 = Todo(id: 2, name: "운동하기",  startDate: Date() - 7 * 86400, endDate: Date() + 30 * 86400, isRepeating: nil, label: [])
        return [stock, stock2, stock3]
    }
    
    init() {
        list = defaultData()
    }
}


extension Todo : Codable, NSItemProviderWriting{
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
}


extension Todo : NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Todo {
        do {
            let subject = try JSONDecoder().decode(Todo.self, from: data)
            return subject
        } catch {
            fatalError()
        }
    }
}
