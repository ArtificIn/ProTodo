//
//  CalendarAddTodoVC.swift
//  proTodo
//
//  Created by 성다연 on 2020/06/11.
//  Copyright © 2020 성다연. All rights reserved.
//

import UIKit

class CalendarAddTodoViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var compleateBtn: UIButton!
    
    @IBOutlet weak var repeatSegmentBtn: UISegmentedControl!
    @IBOutlet weak var repeatTextField: UITextField!
    
    @IBOutlet weak var labelManageBtn: UIButton!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var projectView: UIView!
    
    @IBOutlet weak var labelViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var projectViewTopConstraint: NSLayoutConstraint!
    
    @IBAction func cancleBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
