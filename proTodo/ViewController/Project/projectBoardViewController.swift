//
//  projectDetailViewController.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/19.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

class projectBoardViewController: UIViewController {
    @IBOutlet weak var firstTableView: UITableView!{
        didSet {
            firstTableView.delegate = self
            firstTableView.dataSource = self
            firstTableView.dropDelegate = self
            firstTableView.dragDelegate = self
            firstTableView.dragInteractionEnabled = true
        }
    }
    @IBOutlet weak var secondTableView: UITableView! {
        didSet {
            secondTableView.delegate = self
            secondTableView.dataSource = self
            secondTableView.dropDelegate = self
            secondTableView.dragDelegate = self
            secondTableView.dragInteractionEnabled = true
        }
    }
    
    private var dragView : UIView?
    private var startTableView: UITableView?
    private var startIndexPath: IndexPath?
    
    private var firstItems = testModelList().array
    private var secondItems = testModelList().array
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension projectBoardViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoModel.shared.arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: projectBoardTableViewCell.cellID) as! projectBoardTableViewCell
        cell.todoLabel.text = TodoModel.shared.arrayList[indexPath.row].name
        return cell
    }
}


extension projectBoardViewController : UITableViewDragDelegate, UITableViewDropDelegate {
  
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let coordinator = CacheDragCoordinator(sourceIndexPath: indexPath)
        session.localContext = coordinator
        let item = tableView == firstTableView ? firstItems : secondItems
        let movingCard = item[indexPath.row]
        let provider = NSItemProvider(object: movingCard as! NSItemProviderWriting)
        
        startTableView = tableView
        startIndexPath = indexPath
        
        return [UIDragItem(itemProvider: provider)]
    }
    
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath : IndexPath
        
        if let indexpath = coordinator.destinationIndexPath {
            destinationIndexPath = indexpath
        } else {
            destinationIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            let stringItems = items as! [String]
            var indexPaths = [IndexPath]()
            
            for (index, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                var model = tableView == self.firstTableView ? self.firstItems : self.secondItems
                
                if tableView == self.firstTableView {
                    self.firstTableView.insertRows(at: [destinationIndexPath], with: .automatic)
//                    firstItems.insert(, at: destinationIndexPath.item)
                } else {
                    self.secondTableView.insertRows(at: [destinationIndexPath], with: .automatic)
                   
                }
                
                indexPaths.append(indexPath)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        
        if tableView.hasActiveDrag {
            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
                print("draging")
            }
        } else {
            // drag is comming from outside from app
            print("drag come from outside from app")
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
            
            
        }
        return dropProposal
    }
    
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        guard let dragCoordinator = session.localContext as? CacheDragCoordinator,
              dragCoordinator.dragCompleted == true,
              dragCoordinator.isReordering == false else {
            return
        }
        
        let sourceIndexPath = dragCoordinator.sourceIndexPath
        
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
        })
    }
}


class CacheDragCoordinator {
    let sourceIndexPath : IndexPath
    var dragCompleted = false
    var isReordering = false
    
    init(sourceIndexPath: IndexPath) {
        self.sourceIndexPath = sourceIndexPath
    }
}

final class testModel : Codable {
    let name : String
    
    init(name: String) {
        self.name = name
    }
}

final class testModelList : Codable {
    let array : [testModel] = [testModel(name: "네이버"), testModel(name: "카카오"), testModel(name: "라인")
    ]
    
    init() {
        
    }
}
