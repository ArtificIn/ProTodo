//
//  projectCollectionViewCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/16.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

class projectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private let viewModel = ProjectModel.shared.projectList
}

extension projectCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
//        let cell = tableView.dequeueReusableCell(withIdentifier: "projectTableViewCell") as! projectTableViewCell
//        return cell
    }
}
