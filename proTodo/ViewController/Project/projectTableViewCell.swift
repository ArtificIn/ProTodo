//
//  projectTableViewCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/16.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit
import FSCalendar

class projectTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    static let CellID = "projectTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindViewModel(project: Project) {
        dateLabel.text = project.endDate.isEmpty ? "D-Day None" : "D-Day \(calculateDDay(to: project.endDate))"
        titleLabel.text = project.name
        progressView.progress = 0.3
    }
    
    func calculateDDay(to: String) -> Int {
        let dateformatter = DateFormatter()
        let calendar = Calendar.current
        dateformatter.dateFormat = "yyyy.MM.dd"
        guard let end = dateformatter.date(from: to) else { return 0 }
        let components = calendar.dateComponents([.day], from: Date(), to: end)
        return components.day!
    }
}
