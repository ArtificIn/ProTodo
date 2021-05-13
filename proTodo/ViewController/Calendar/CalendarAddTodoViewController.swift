//
//  CalendarAddTodoVC.swift
//  proTodo
//
//  Created by 성다연 on 2020/06/11.
//  Copyright © 2020 성다연. All rights reserved.
//

import UIKit

class CalendarAddTodoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var dateLabel: UILabel!
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
                isRepeating = 0
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
        if !text.trimmingCharacters(in: .whitespaces).isEmpty {
            createTag(name: text, color: color)
        }
        showCreateLabelView(isTrue: false)
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
        guard let text = titleTextField.text else { return }
        createTodo(name: text, color: color, startDate: startDatePicker.date, endDate: endDatePicker.date, isRepeat: isRepeating, tag: [selectedTag])
        selectedTag = nil
        delegate?.refreshMain(0)
        dismiss(animated: true)
    }
    
    static let cellID = "CalendarAddTodoViewController"
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var selectedTag : ManagedTag?
    private var color : Int = 0x625FDC
    private var isRepeating: Int = 0
    private var labels : [ManagedTag] = []
    
    var delegate : MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDatePicker.date = selectDate
        endDatePicker.date = selectDate
        dateLabel.text = selectDate.Date2String(format: "MM월 dd일")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllItems()
        selectedTag = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // Core Data
    
    func getAllItems() {
        do {
            labels = try context.fetch(ManagedTag.fetchRequest())

            DispatchQueue.main.async {
                self.labelCollectionView.reloadData()
            }
        } catch {
            print("CalendarAddTodoVC - Tag를 가져올 수 없습니다. error:",error)
        }
    }
    
    private func createTag(name:String, color: Int) {
        let newTag = ManagedTag(context: context)
        newTag.name = name
        newTag.color = Int32(color)
        
        do {
            try context.save()
            getAllItems()
        } catch {
            print("CalendarAddTodoVC - Tag를 생성할 수 없습니다. error:",error)
        }
    }
    
    private func deleteTag(tag: ManagedTag) {
        context.delete(tag)
        
        do {
            try context.save()
        } catch {
            print("CalendarAddTodoVC - Tag를 삭제할 수 없습니다. error:",error)
        }
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

    private func createTodo(name: String, color: Int, startDate: Date, endDate: Date, isRepeat: Int, tag: Set<ManagedTag?>) {
        let newItem = ManagedTodo(context: context)
        newItem.name = name
        newItem.isRepeating = Int32(isRepeat)
        newItem.tag = tag.first! == nil ? [] :  Set(tag.map { $0!})
        newItem.startDate = startDate
        newItem.endDate = endDate
        
        do {
            try context.save()
        } catch {
            print("CalendarAddTodo - Todo를 생성할 수 없습니다. error:",error)
        }
    }
}


extension CalendarAddTodoViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == labelCollectionView ? labels.count : Colors.arrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == labelCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarTagCollectionViewCell.CellID, for: indexPath) as! CalendarTagCollectionViewCell
            cell.bindViewModel(tag: labels[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarTagColorCollectionViewCell.cellID, for: indexPath) as! CalendarTagColorCollectionViewCell
            cell.bindViewModel(color: Colors.arrays[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == labelCollectionView {
            selectedTag = labels[indexPath.row]
        } else {
            color = Colors.arrays[indexPath.row]
            createLabelTextFieldBackgroundView.backgroundColor = UIColor.colorRGBHex(hex: color)
        }
    }
}


