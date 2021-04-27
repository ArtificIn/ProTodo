//
//  ProjectCreateViewController.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/26.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

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
            let newProject = Project2(name: text, startDate: Date(), endDate: endDatePicker.date, list: list)
            
            ProjectModel.shared.list.append(newProject)
            delegate?.refreshMainViewController()
            dismiss(animated: true)
        }
    }
    
    static let cellID = "ProjectCreateViewController"
    var delegate : MainViewControllerDelegate?
    
    private var list : [ProjectBoard] = [
        .init(id: 0, category: .todoList, todoList: []),
        .init(id: 1, category: .doingList, todoList: []),
        .init(id: 2, category: .doneList, todoList: [])
    ]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let text = section == list.count ? "추가하기" : list[section].category.getName()
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
