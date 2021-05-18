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
            tableView.dragDelegate = self
            tableView.dragInteractionEnabled = true
        }
    }
    
    static let cellID = "ProjectBoardCollectionViewCell"
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var board : ManagedProjectBoard!
    private var todoList : [Todo] = []
    private var managedTodoList : [ManagedTodo] = []
    private var selectIndexPath = (IndexPath(), false)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(board : ManagedProjectBoard) {
        self.board = board
        boardNameLabel.text = board.category
        getAllItems()
    }
    
    func getAllItems(){
        do {
            managedTodoList = try context.fetch(ManagedTodo.fetchRequest())
            todoList = managedTodoList.filter { $0.board == board }.map { $0.toTodo() }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("ProjectBoardCC - Todo를 가져올 수 없습니다. error:",error)
        }
    }
    
    func insertTodoAtBoard(todo : Todo) {
        guard let item = managedTodoList.filter({ $0.name == todo.name && $0.id == todo.id}).first, var list = board.todo else {return}
        item.board = board
        list.update(with: item)
        
        do {
            try context.save()
        } catch {
            print("ProjectBoardCC - Todo를 추가할 수 없습니다.")
        }
    }
    
    func removeTodoAtBouard(todo: Todo) {
        guard let item = managedTodoList.filter({ $0.name == todo.name && $0.id == todo.id}).first, var list = board.todo else {return}
        list.remove(item)
        do {
            try context.save()
        } catch {
            print("ProjectBoardCC - Todo를 삭제할 수 없습니다.")
        }
    }
}


extension ProjectBoardCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectBoardTableViewCell.cellID) as! ProjectBoardTableViewCell
        cell.bindViewModel(todo: todoList[indexPath.row])
        return cell
    }
}


extension ProjectBoardCollectionViewCell : UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Todo.self)
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
        
        coordinator.session.loadObjects(ofClass: Todo.self) { items in
            guard let subject = items as? [Todo] else { return }
            var indexPaths = [IndexPath]()
            
            for (index, item) in subject.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                self.insertTodoAtBoard(todo: item)
                self.todoList.insert(item, at: indexPath.row)
                indexPaths.append(indexPath)
            }
            
            tableView.beginUpdates()
            tableView.insertRows(at: indexPaths, with: .automatic)
            tableView.endUpdates()
        }
    }
}


extension ProjectBoardCollectionViewCell : UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: todoList[indexPath.row])
        selectIndexPath = (indexPath, false)
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        removeTodoAtBouard(todo: todoList[selectIndexPath.0.row])
        todoList.remove(at: selectIndexPath.0.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [selectIndexPath.0], with: .automatic)
        tableView.endUpdates()
    }
}
