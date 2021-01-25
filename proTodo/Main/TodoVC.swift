//
//  TodoVC.swift
//  proTodo
//
//  Created by 성다연 on 30/09/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

class TodoVC: UIViewController {
    @IBOutlet weak var todoList: UITableView!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var menuBar: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var selectedIndex : NSInteger! = -1
    var isReapeat : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.todoList.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        createSegmentedControl()
        dateSetting()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension TodoVC {
    private func delegate(){
        todoList.delegate = self
        todoList.dataSource = self
        self.todoList.isEditing = true
    }
        
    private func createSegmentedControl(){
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50),
                buttonTitle:["Calendar", "Project"])

        codeSegmented.backgroundColor = UIColor.colorRGBHex(hex: 0x373535)
        view.addSubview(codeSegmented)
    }
    
    private func dateSetting(){
        let date = Date2String(date: Date(), format: "MM월 YYYY").split(separator: " ")
        let month = NSMutableAttributedString(string: String(date[0]) + "  ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26)])
        let year = NSMutableAttributedString(string: String(date[1]), attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        
        month.append(year)
        self.dateLabel.attributedText = month
    }
}




extension TodoVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Database.arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = Database.arrayList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todocell") as! todoCell
            
        cell.textField?.text = todo.memo
        cell.colorView.backgroundColor = UIColor.colorRGBHex(hex: todo.color)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
   
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
}
