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
            tableView.dropDelegate = self
            tableView.dragInteractionEnabled = true
        }
    }
    
    static let cellID = "ProjectBoardCollectionViewCell"
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var board : ManagedProjectBoard?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(board : ManagedProjectBoard) {
        self.board = board
        boardNameLabel.text = board.category
    }
}


extension ProjectBoardCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let b = board else { return 0 }
        return b.todoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let b = board else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectBoardTableViewCell.cellID) as! ProjectBoardTableViewCell
//        cell.bindViewModel(todo: b.todoList[indexPath.row])
        return cell
    }
}


extension ProjectBoardCollectionViewCell : UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Todo2.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        guard session.items.count == 1 else { return dropProposal }
       
        if tableView.hasActiveDrag {
            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            // drag is comming from outside from app
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
        return dropProposal
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        var destinationIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
        if let indexpath = coordinator.destinationIndexPath {
            destinationIndexPath = indexpath
        }
        
        coordinator.session.loadObjects(ofClass: Todo2.self) { [weak self] items in
            guard let subject = items as? [Todo2] else { return }
            var indexPaths = [IndexPath]()
            
            for (index, value) in subject.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                
//                self?.board!.todoList.insert(value, at: indexPath.row)
                indexPaths.append(indexPath)
            }
            
            tableView.beginUpdates()
            tableView.insertRows(at: indexPaths, with: .automatic)
            tableView.endUpdates()
        }
    }
}
