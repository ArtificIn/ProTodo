//
//  projectDetailViewController.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/19.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class ProjectBoardViewController: UIViewController {
    @IBOutlet weak var projectDateLabel: UILabel! {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            var date = formatter.string(from: project.startDate!)
            
            if project.endDate != nil {
                let end = formatter.string(from: project.endDate!)
                date.append(" ~ " + end)
            }
            
            projectDateLabel.text = date
        }
    }
    @IBOutlet weak var boardCollectionView: UICollectionView! {
        didSet {
            boardCollectionView.delegate = self
            boardCollectionView.dataSource = self
            boardCollectionView.decelerationRate = .fast
        }
    }
    @IBOutlet weak var todoListView: UIView!
    @IBOutlet weak var showTodoListButton: UIButton!
    @IBAction func showTodoListButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            if self?.todoListTableViewBottomConstraint.constant == 0 {
                self?.showTodoListButton.transform = CGAffineTransform(rotationAngle: .pi)
                self?.todoListTableViewBottomConstraint.constant = -250
            } else {
                self?.showTodoListButton.transform = CGAffineTransform(rotationAngle: 0)
                self?.todoListTableViewBottomConstraint.constant = 0
            }
            self?.view.layoutIfNeeded()
        })
    }
    @IBOutlet weak var todoListTableView: UITableView! {
        didSet {
            todoListTableView.delegate = self
            todoListTableView.dataSource = self
            todoListTableView.dropDelegate = self
            todoListTableView.dragDelegate = self
            todoListTableView.dragInteractionEnabled = true
        }
    }
    @IBOutlet weak var todoListTableViewBottomConstraint: NSLayoutConstraint!
    
    static let cellID = "ProjectBoardViewController"
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var selectIndexPath : (IndexPath, Bool)?
    private var todoList : [Todo] = []
    private var managedTodoItems : [ManagedTodo] = []
    private let collectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.headerReferenceSize = CGSize(width: 20, height: 0)
        layout.footerReferenceSize = CGSize(width: 20, height: 0)
        return layout
    }()
    
    var project : ManagedProject!
    var delegate : MainViewControllerDelegate?
    
    private var previousOffset: CGFloat = 0
    private var currentPage = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpCollectionVieWLayout()
        getAllTodoItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.refreshMain(IndexPath(item: 1, section: 0))
    }
   
    private func setUpSubViews() {
        navigationItem.title = project!.name
        showTodoListButton.transform = CGAffineTransform(rotationAngle: .pi)
        todoListTableViewBottomConstraint.constant = -250
    }
    
    private func setUpCollectionVieWLayout() {
        collectionViewLayout.itemSize = CGSize(width: boardCollectionView.bounds.width - 60, height: boardCollectionView.bounds.height - 80)
        boardCollectionView.collectionViewLayout = collectionViewLayout
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let point = self.targetContentOffset(scrollView, withVelocity: velocity)
        targetContentOffset.pointee = point
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
            self.boardCollectionView.setContentOffset(point, animated: true)
        }, completion: nil)
    }
    
    func targetContentOffset(_ scrollView: UIScrollView, withVelocity velocity: CGPoint) -> CGPoint {
        guard let flowLayout = boardCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        if previousOffset > boardCollectionView.contentOffset.x && velocity.x < 0 {
            currentPage = currentPage - 1
        } else if previousOffset < boardCollectionView.contentOffset.x && velocity.x > 0 {
            currentPage = currentPage + 1
        }
        
        let additional = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing) - flowLayout.headerReferenceSize.width
        let updatedOffset = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing) * CGFloat(currentPage) - additional - 20
        
        previousOffset = updatedOffset
        
        return CGPoint(x: updatedOffset, y: 0)
    }
    
    // Core Data
    func getAllTodoItems() {
        do {
            managedTodoItems = try context.fetch(ManagedTodo.fetchRequest())
            todoList = managedTodoItems.map { $0.toTodo() }
            
            DispatchQueue.main.async {
                self.todoListTableView.reloadData()
            }
        } catch {
            print("ProjectBoardVC - Todo를 가져올 수 없습니다. error:",error)
        }
    }
}

extension ProjectBoardViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectBoardTableViewCell.cellID) as! ProjectBoardTableViewCell
        cell.bindViewModel(todo: todoList[indexPath.row])
        return cell
    }
}


extension ProjectBoardViewController : UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: todoList[indexPath.row] as NSItemProviderWriting)
        selectIndexPath = (indexPath, false)
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        guard let selectIndexPath = selectIndexPath else { return }
       
        if selectIndexPath.1 {
            todoList.remove(at: selectIndexPath.0.row)
//                secondItems.remove(at: selectIndexPath.0.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [selectIndexPath.0], with: .automatic)
            tableView.endUpdates()
        }
    }
}


extension ProjectBoardViewController : UITableViewDropDelegate {
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
            if let indexPath = selectIndexPath {
                selectIndexPath = (indexPath.0, true)
            }
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
//            guard let subject = items as? [Todo] else { return }
//            var indexPaths = [IndexPath]()
//
//            tableView.beginUpdates()
//            tableView.insertRows(at: [IndexPath](), with: .automatic)
//            tableView.endUpdates()
        }
    }
}


extension ProjectBoardViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let b = project.boardList else { return 0 }
        return b.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectBoardCollectionViewCell.cellID, for: indexPath) as! ProjectBoardCollectionViewCell
        guard let b = project.boardList else { return UICollectionViewCell() }
        if let p = b.filter({ $0.id == indexPath.row }).first {
            cell.bindViewModel(board: p)
        }
        cell.handleBorder()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 60, height: collectionView.bounds.height - 80)
    }
}
