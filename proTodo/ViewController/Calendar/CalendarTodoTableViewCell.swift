//
//  todoCell.swift
//  proTodo
//
//  Created by 성다연 on 30/09/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit
import CoreData

class CalendarTodoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var repeatBtn: Checkbox!
    
    static let CellID = "CalendarTodoTableViewCell"
    var isRepeat : Bool = false
    var listItems: Todo?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(todo : NSManagedObject) {
        titleLabel.text = todo.value(forKey: "name") as! String
        let color = todo.value(forKey: "color") as! Int
        colorView.backgroundColor = UIColor.colorRGBHex(hex: color)
    }
}


extension CalendarTodoTableViewCell{
    func ButtonSetting(){
        repeatBtn.addTarget(self, action: #selector(touchRepeatBtn), for: .touchUpInside)
    }
    
    @objc func touchRepeatBtn(){
       
    }
}
