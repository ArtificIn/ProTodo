//
//  projectCollectionViewCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/16.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

class projectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boardNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    static let CellID = "projectCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(project: Project){
        boardNameLabel.text = project.name
    }
}

extension projectCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: projectTableViewCell.CellID) as! projectTableViewCell
        cell.bindViewModel(project: ProjectModel.shared.projectList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
