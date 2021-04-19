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
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var repeatSegmentBtn: UISegmentedControl!
    @IBOutlet weak var repeatTextField: UITextField!
    
    @IBOutlet weak var labelCollectionView: UICollectionView!{
        didSet {
            labelCollectionView.collectionViewLayout = LabelCollectionViewLayout()
            labelCollectionView.delegate = self
            labelCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var compleateBtn: UIButton!
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
        newTag = Tag(id: 0, name: text, color: color)
        TagModel.shared.tagList.append(newTag!)
        showCreateLabelView(isTrue: false)
        labelCollectionView.reloadData()
    }
    @IBAction func createLabelCancleButton(_ sender: UIButton) {
        showCreateLabelView(isTrue: false)
    }
    @IBAction func cancleBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func labelSettingButton(_ sender: UIButton) {
        showCreateLabelView(isTrue: true)
    }
    
    private var newTag : Tag?
    private var color : Int = 0x625FDC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelBackgroundView()
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
}


extension CalendarAddTodoViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == labelCollectionView ? TagModel.shared.tagList.count : Colors.arrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == labelCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelCollectionViewCell.CellID, for: indexPath) as! labelCollectionViewCell
        cell.bindViewModel(tag: TagModel.shared.tagList[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createLabelCollectionViewCell.cellID, for: indexPath) as! createLabelCollectionViewCell
            cell.bindViewModel(color: Colors.arrays[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == labelCollectionView {
            
        } else {
            color = Colors.arrays[indexPath.row]
            createLabelTextFieldBackgroundView.backgroundColor = UIColor.colorRGBHex(hex: color)
        }
    }
}


