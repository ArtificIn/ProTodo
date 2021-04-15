//
//  todoData.swift
//  proTodo
//
//  Created by 성다연 on 30/09/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import Foundation

let Database : TodoModel = TodoModel()
let TodoFileName = "ProTodoList.file"
let projectName = "ProTodo"


class TodoModel {
    var arrayList : [Todo] = [] // 일반 저장
    var repeatList : [Todo] = [] // 반복하는 할일 저장
    
    var mainfilePath: String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/" + projectName + "/" + TodoFileName
        }}
    
    func saveData(){
        NSKeyedArchiver.archiveRootObject(self.arrayList, toFile: self.mainfilePath)
    }
    
    func defaultData() -> Array<Todo>{
        let stock = Todo(memo: "앱 업데이트", color: 0xafeeee, update: Date())
        let stock2 = Todo(memo: "쇼핑하기", color: 0xffbe46, update: Date() - 86400)
        let stock3 = Todo(memo: "운동하기", color: 0x34de53, update: Date())
        return [stock, stock2, stock3]
    }
    
    init() {
        if FileManager.default.fileExists(atPath: self.mainfilePath){
            if let mainArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.mainfilePath) as? [Todo] {
                arrayList = mainArray
            }
        } else {
            arrayList = defaultData()
        }
    }
}

class Todo : NSObject, NSCoding {
    var memo : String
    var color : Int
    var update : Date // 소속 날짜
    
    init(memo:String, color:Int, update: Date) {
        self.memo = memo
        self.color = color
        self.update = update
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.memo, forKey: "memo")
        coder.encode(self.color, forKey: "color")
        coder.encode(self.update, forKey: "update")
    }
    
    required init?(coder: NSCoder) {
        self.memo = coder.decodeObject(forKey: "memo") as! String
        self.color = coder.decodeObject(forKey: "color") as! Int
        self.update = coder.decodeObject(forKey: "update") as! Date
    }
}

