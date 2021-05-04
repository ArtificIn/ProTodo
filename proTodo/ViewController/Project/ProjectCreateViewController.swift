//
//  ProjectCreateViewController.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/26.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit
import CoreData

class ProjectCreateViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func completeButton(_ sender: UIButton) {
        guard var text = nameTextField.text else { return }
        text = text.trimmingCharacters(in: .whitespaces)
        
        if !text.isEmpty {
            createItem(name: text, list: list, startDate: Date(), endDate: endDatePicker.date)
            
            dismiss(animated: true)
        }
    }
    
    static let cellID = "ProjectCreateViewController"
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models : [ManagedProject] = []
    var delegate : MainViewControllerDelegate?
    
    private var list : Set<ManagedProjectBoard> = [
    ]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryList()
        getAllItems()
    }
    
    private func setCategoryList(){
        let board1 = ManagedProjectBoard(context: context)
        board1.id = 0
        board1.category = "Todo"
        board1.todoList = []
        
        let board2 = ManagedProjectBoard(context: context)
        board2.id = 1
        board2.category = "Doing"
        board2.todoList = []
        
        let board3 = ManagedProjectBoard(context: context)
        board3.id = 2
        board3.category = "Done"
        board3.todoList = []
        
        list.update(with: board1)
        list.update(with: board2)
        list.update(with: board3)
    }
    
    private func getAllItems() {
        do {
            models = try context.fetch(ManagedProject.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("ProjectCreateVC - project를 가져올 수 없습니다. error:",error)
        }
    }
    
    private func createItem(name : String, list : Set<ManagedProjectBoard>, startDate: Date, endDate: Date ) {
        
        let newItem = ManagedProject(context: context)
        newItem.name = name
        newItem.boardList = list
        newItem.startDate = startDate
        newItem.endDate = endDate
    
        do {
            try context.save()
            getAllItems()
        } catch {
            print("ProjectCreateVC - project를 생성할 수 없습니다. error:",error)
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
            print("ProjectCreateVC - project를 수정할 수 없습니다. error:",error)
        }
    }
}


extension ProjectCreateViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCreateTableViewCell.cellID) as! ProjectCreateTableViewCell
        let text = section == list.count ? "추가하기" : list[list.index(list.startIndex, offsetBy: section)].category
        cell.boardLabel.text = text
        cell.handleBorder()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}
