//
//  projectTableViewCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/16.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit
import FSCalendar

class ProjectTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    static let CellID = "ProjectTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func bindViewModel(project: ManagedProject) {
        dateLabel.text = project.endDate == nil ? "D-Day None" : "D-Day \(calculateDDay(date: project.endDate))"
        titleLabel.text = project.name
        
        guard let board = project.boardList,
              let b = board.filter({ $0.id == 0}).first,
              let todoList = b.todo else { return }
        let totalCount = board.map { $0.todo!.count}.reduce(0, +)
       
        progressView.progress = totalCount == 0 ? 1 : 1 - Float(todoList.count)/Float(totalCount)
    }
    
    func calculateDDay(date: Date?) -> Int {
        guard let dday = date else { return 0 }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: dday)
        return components.day!
    }
}
