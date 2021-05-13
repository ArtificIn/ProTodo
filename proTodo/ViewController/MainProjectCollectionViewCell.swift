//
//  projectCollectionViewCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/16.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit
import CoreData

class MainProjectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    static let CellID = "MainProjectCollectionViewCell"
    var models : [ManagedProject] = []
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate : MainViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getAllItems()
    }
    
    // Core Data
    func getAllItems(){
        do {
            models = try context.fetch(ManagedProject.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("MainProjectCC - project를 가져올 수 없습니다. error :", error)
        }
    }
    
    private func deleteItems(item: ManagedProject) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            print("MainProjectCC - project를 삭제할 수 없습니다. error:",error)
        }
    }
    
    private func updateItem(item: ManagedProject, newItem: ManagedProject) {
        item.name = newItem.name
        item.boardList = newItem.boardList
        item.startDate = newItem.startDate
        item.endDate = newItem.endDate
        
        do {
            try context.save()
        } catch {
            print("MainProjectCC - project를 수정할 수  없습니다. error:",error)
        }
    }
    
    func refresh() {
        tableView.reloadData()
    }
}

extension MainProjectCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.CellID) as! ProjectTableViewCell
        cell.bindViewModel(project: models[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.presentProjectBoardViewController(project: models[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
