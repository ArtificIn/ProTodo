//
//  Date+.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/15.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func Date2String(format : String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: self)
    }
}
