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
    @IBOutlet weak var repeatBtn: Checkbox!
    @IBOutlet weak var tagButton: UIButton! {
        didSet {
            tagButton.isHidden = true
            tagButton.titleEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        }
    }
    
    static let CellID = "CalendarTodoTableViewCell"
    var isRepeat : Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(todo : NSManagedObject) {
        titleLabel.text = todo.value(forKey: "name") as? String
        guard let tag = todo.value(forKey: "tag") as? Set<ManagedTag>, let first = tag.first else { return}
        tagButton.isHidden = false
        tagButton.backgroundColor = UIColor.colorRGBHex(hex: Int(first.color))
        tagButton.setTitle(first.name!+"    ", for: .normal)
    }
}


extension CalendarTodoTableViewCell{
    func ButtonSetting(){
        repeatBtn.addTarget(self, action: #selector(touchRepeatBtn), for: .touchUpInside)
    }
    
    @objc func touchRepeatBtn(){
       
    }
}
