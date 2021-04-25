//
//  ProjectCollectionViewCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/25.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

class ProjectBoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boardNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    static let cellID = "ProjectBoardCollectionViewCell"
    var board : ProjectBoard?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(board : ProjectBoard) {
        self.board = board
        boardNameLabel.text = board.category.rawValue
    }
}


extension ProjectBoardCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board?.todoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let b = board else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectBoardTableViewCell.cellID) as! ProjectBoardTableViewCell
        cell.bindViewModel(todo: b.todoList[indexPath.row])
        return cell
    }
}
