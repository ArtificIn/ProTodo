//
//  CalendarAddTodoVC.swift
//  proTodo
//
//  Created by 성다연 on 2020/06/11.
//  Copyright © 2020 성다연. All rights reserved.
//

import UIKit

class CalendarAddTodoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBAction func startDatePicker(_ sender: UIDatePicker) {
        if endDatePicker.date < sender.date {
            endDatePicker.setDate(sender.date, animated: true)
        }
        endDatePicker.minimumDate = startDatePicker.date
    }
    @IBOutlet weak var startDatePicker: UIDatePicker! {
        didSet {
            startDatePicker.minimumDate = Date()
        }
    }
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBAction func endDatePicker(_ sender: UIDatePicker) {
        if sender.date < startDatePicker.date {
            sender.setDate(startDatePicker.date, animated: true)
        }
    }
    
    @IBAction func repeatSegmentControl(_ sender: UISegmentedControl) {
        guard let text = repeatTextField.text else {return}
        if text.isEmpty {
            
            switch sender.selectedSegmentIndex {
            case 1:
                isRepeating = 1
            case 2:
                isRepeating = 7
            case 3:
                isRepeating = 30
            case 4:
                isRepeating = 364
            default:
                isRepeating = nil
            }
        }
    }
    @IBOutlet weak var repeatTextField: UITextField!
    @IBAction func repeadTextField(_ sender: UITextField) {
        guard let text = sender.text else {return}
        isRepeating = Int(text)!
    }
    
    
    @IBOutlet weak var labelCollectionView: UICollectionView!{
        didSet {
            labelCollectionView.collectionViewLayout = LabelCollectionViewLayout()
            labelCollectionView.delegate = self
            labelCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var createLabelBackgroundView: UIView!
    @IBOutlet weak var createLabelView: UIView!
    @IBOutlet weak var createLabelTextFieldBackgroundView: UIView!
    @IBOutlet weak var createLabelTextField: UITextField!
    @IBOutlet weak var createLabelCollectionView: UICollectionView! {
        didSet {
            createLabelCollectionView.delegate = self
            createLabelCollectionView.dataSource = self
        }
    }
    @IBAction func createLabelCompleteButton(_ sender: UIButton) {
        guard let text = createLabelTextField.text else { return }
        newTag = Tag2(id: 0, name: text, color: color)
        TagModel.shared.tagList.append(newTag!)
        showCreateLabelView(isTrue: false)
        labelCollectionView.reloadData()
    }
    @IBAction func createLabelCancleButton(_ sender: UIButton) {
        showCreateLabelView(isTrue: false)
    }
    @IBAction func cancleBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func labelSettingButton(_ sender: UIButton) {
        showCreateLabelView(isTrue: true)
    }
    @IBAction func completeButton(_ sender: UIButton) {
        createTodo()
        dismiss(animated: true)
    }
    
    static let cellID = "CalendarAddTodoViewController"
    
    private var newTag : Tag2?
    private var newTodo : Todo2?
    private var color : Int = 0x625FDC
    private var isRepeating: Int?
    private var labels : [Tag2] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setLabelBackgroundView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setLabelBackgroundView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        createLabelBackgroundView.addGestureRecognizer(tap)
    }
    
    @objc private func handleTapGesture(_ sender : UITapGestureRecognizer){
        showCreateLabelView(isTrue: false)
    }
    
    private func showCreateLabelView(isTrue: Bool) {
        switch isTrue {
        case true:
            createLabelBackgroundView.isHidden = false
            createLabelView.isHidden = false
        case false:
            createLabelBackgroundView.isHidden = true
            createLabelView.isHidden = true
        }
    }
    
    private func createTodo() {
        guard let text = titleTextField.text else { return }
        let todo = Todo2(id: TodoModel.shared.list.count - 1, name: text, color: color, startDate: startDatePicker.date, endDate: endDatePicker.date, isRepeating: isRepeating, label: labels)
        TodoModel.shared.list.append(todo)
    }
}


extension CalendarAddTodoViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == labelCollectionView ? TagModel.shared.tagList.count : Colors.arrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == labelCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarTagCollectionViewCell.CellID, for: indexPath) as! CalendarTagCollectionViewCell
        cell.bindViewModel(tag: TagModel.shared.tagList[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarTagColorCollectionViewCell.cellID, for: indexPath) as! CalendarTagColorCollectionViewCell
            cell.bindViewModel(color: Colors.arrays[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == labelCollectionView {
            let item = TagModel.shared.tagList[indexPath.row]
            if !labels.contains(where: { $0 == item }) {
                labels.append(item)
            }
        } else {
            color = Colors.arrays[indexPath.row]
            createLabelTextFieldBackgroundView.backgroundColor = UIColor.colorRGBHex(hex: color)
        }
    }
}


