//
//  projectBoardTableViewCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/19.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

class ProjectBoardTableViewCell: UITableViewCell {
    @IBOutlet weak var todoLabel: UILabel!
    
    static let cellID = "ProjectBoardTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindViewModel(todo : Todo) {
        todoLabel.text = todo.name
    }
}
