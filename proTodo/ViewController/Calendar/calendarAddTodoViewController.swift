//
//  CalendarAddTodoVC.swift
//  proTodo
//
//  Created by 성다연 on 2020/06/11.
//  Copyright © 2020 성다연. All rights reserved.
//

import UIKit

class CalendarAddTodoViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var repeatSegmentBtn: UISegmentedControl!
    @IBOutlet weak var repeatTextField: UITextField!
    
    @IBOutlet weak var labelCollectionView: UICollectionView!
    @IBOutlet weak var labelManageBtn: UIButton!
    
    @IBOutlet weak var compleateBtn: UIButton!

    @IBAction func cancleBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension CalendarAddTodoViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TagModel.shared.tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelCollectionViewCell.CellID, for: indexPath) as! labelCollectionViewCell
        
        return cell
    }
}
