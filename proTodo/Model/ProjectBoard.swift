//
//  ProjectBoard.swift
//  proTodo
//
//  Created by 성다연 on 2021/05/02.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation
import CoreData

@objc public enum Category : Int {
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
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case 0:
            self = .todoList
        case 1:
            self = .doingList
        case 2:
            self = .doneList
        default:
            return nil
        }
    }
}
