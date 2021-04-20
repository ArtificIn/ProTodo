//
//  projectDetailViewController.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/19.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit
import MobileCoreServices

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

    private var selectIndexPath : (IndexPath, Bool)?
    private var firstItems = [Subject(id: "네이버"), Subject(id: "카카오"), Subject(id: "라인")]
    private var secondItems = [Subject(id: "할리스"), Subject(id: "스타벅스"), Subject(id: "투썸")]
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension projectBoardViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == firstTableView ? firstItems.count : secondItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: projectBoardTableViewCell.cellID) as! projectBoardTableViewCell
        cell.todoLabel.text = tableView == firstTableView ?
            firstItems[indexPath.row].id : secondItems[indexPath.row].id
        return cell
    }
}


extension projectBoardViewController : UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let model = tableView == self.firstTableView ? self.firstItems : self.secondItems
        let itemProvider = NSItemProvider(object: model[indexPath.row] as NSItemProviderWriting)
        selectIndexPath = (indexPath, false)
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        guard let selectIndexPath = selectIndexPath else { return }
        if selectIndexPath.1 {
            if tableView == firstTableView {
                firstItems.remove(at: selectIndexPath.0.row)
            } else {
                secondItems.remove(at: selectIndexPath.0.row)
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: [selectIndexPath.0], with: .automatic)
            tableView.endUpdates()
        }
    }
}


extension projectBoardViewController : UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Subject.self)
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
        
        coordinator.session.loadObjects(ofClass: Subject.self) { [self] items in
            guard let subject = items as? [Subject] else { return }
            var indexPaths = [IndexPath]()
            
            for (index, value) in subject.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                
                if tableView == self.firstTableView {
                    self.firstItems.insert(value, at: indexPath.row)
                } else {
                    self.secondItems.insert(value, at: indexPath.row)
                }
                indexPaths.append(indexPath)
            }
            
            tableView.beginUpdates()
            tableView.insertRows(at: indexPaths, with: .automatic)
            tableView.endUpdates()
        }
    }
}

final class Subject : NSObject {
    let id : String
    
    init(id : String) {
        self.id = id
    }
}

extension Subject : NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
        
    }
}

extension Subject : Codable, NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Subject {
        do {
            let subject = try JSONDecoder().decode(Subject.self, from: data)
            return subject
        } catch {
            fatalError()
        }
    }
}

