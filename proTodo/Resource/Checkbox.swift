//
//  Checkbox.swift
//  proTodo
//
//  Created by 성다연 on 30/09/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

class Checkbox: UIButton {
    let checkedImage = UIImage(named: "checkbox") as UIImage?
    let unCheckedImage = UIImage(named: "uncheckbox") as UIImage?
    
    var isChecked:Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            }else{
                self.setImage(unCheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender:UIButton) {
        if(sender == self){
            if isChecked == true {
                isChecked = false
            }else{
                isChecked = true
            }
        }
    }
}
