//
//  CalendarVC.swift
//  proTodo
//
//  Created by 성다연 on 2020/06/11.
//  Copyright © 2020 성다연. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController : UIViewController {
    @IBOutlet weak var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        handlePanGesture()
    }
    
    private func handlePanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        view.addGestureRecognizer(pan)
    }
    @objc private func panGesture(_ sender : UIPanGestureRecognizer){
        let velocity = sender.velocity(in: view)
        if abs(velocity.y) > abs(velocity.x) {
            print(velocity.y < 0 ? "up" : "down")
        }
    }
}
