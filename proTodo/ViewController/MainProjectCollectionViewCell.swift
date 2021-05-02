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
            // 현재 fetch가 안되고 있음
            // error
        }
    }
    
    private func deleteItems(item: ManagedProject) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    private func updateItem(item: ManagedProject, newItem: ManagedProject) {
        item.name = newItem.name
        item.list = newItem.list
        item.startDate = newItem.startDate
        item.endDate = newItem.endDate
        
        do {
            try context.save()
        } catch {
            
        }
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
        delegate?.presentProjectBoardViewController(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
