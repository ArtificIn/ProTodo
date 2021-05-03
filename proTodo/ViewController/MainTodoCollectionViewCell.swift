//
//  TodoCollectionCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/01/25.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit
import CoreData
import FSCalendar

class MainTodoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var calendar: FSCalendar! {
        didSet {
            calendar.delegate = self
            calendar.dataSource = self
        }
    }
    @IBOutlet weak var calendar_height_constraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    
    static let cellID = "MainTodoCollectionViewCell"
    private var models : [ManagedTodo] = []
    var isReapeat : Bool = false
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateSetting()
        handlePanGesture()
        getAllItems()
    }

    private func dateSetting(){
        let date = calendar.currentPage
        let dateFormat = date.Date2String(format: "MM월 YYYY").split(separator: " ")
        let month = NSMutableAttributedString(string: String(dateFormat[0]) + "  ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26)])
        let year = NSMutableAttributedString(string: String(dateFormat[1]), attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        
        month.append(year)
        dateLabel.attributedText = month
    }
    
    // Core Data
    
    private func getAllItems() {
        do {
            models = try context.fetch(ManagedTodo.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("MainTodoCC - Todo를 가져올 수 없습니다. error:",error)
        }
    }
    
    private func createItem(name: String) {
        let newItem = ManagedTodo(context: context)
        newItem.name = name
        
        do {
            try context.save()
            getAllItems()
        } catch {
            print("MainTodoCC - Todo를 생성할 수 없습니다. error:",error)
        }
    }
    
    private func deleteItem(item: ManagedTodo) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            print("MainTodoCC - Todo를 삭제할 수 없습니다. error:",error)
        }
    }
    
    private func updateItem(item: ManagedTodo, newItem: ManagedTodo){
        item.name = newItem.name
        
        do {
            try context.save()
        } catch {
            print("MainTodoCC - Todo를 수정할 수 없습니다. error:",error)
        }
    }
}

extension MainTodoCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTodoTableViewCell.CellID) as! CalendarTodoTableViewCell
            
        cell.bindViewModel(todo: models[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
   
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}


extension MainTodoCollectionViewCell : FSCalendarDelegate, FSCalendarDataSource, UIGestureRecognizerDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        dateSetting()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar_height_constraint.constant = bounds.height
        self.layoutIfNeeded()
    }
    
    func handlePanGesture(){
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlingCalendarPanGesture(_:)))
        panGestureRecognizer.delegate = self
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlingCalendarPanGesture(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: self)
        if abs(velocity.y) > abs(velocity.x) {
            calendar.setScope(velocity.y < 0 ? .week : .month, animated: true)
        }
    }
}
