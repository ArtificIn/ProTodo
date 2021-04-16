//
//  todoCell.swift
//  proTodo
//
//  Created by 성다연 on 30/09/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

class todoTableViewCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField! {
        didSet{
            textField.textColor = UIColor.white
            textField.font = UIFont.systemFont(ofSize: 20)
            textField.backgroundColor = UIColor.colorRGBHex(hex: 0x373535)
        }
    }
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var repeatBtn: Checkbox!
    
    let leftMarginForLabel : CGFloat = 10.0
    var isRepeat : Bool = false
    var listItems: Todo?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        guard let item = listItems else { return }
        textField.text = item.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension todoTableViewCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard var item = listItems else { return false }
        item.name = textField.text!
        return true
    }
}


extension todoTableViewCell{
    func ButtonSetting(){
        repeatBtn.addTarget(self, action: #selector(touchRepeatBtn), for: .touchUpInside)
    }
    
    @objc func touchRepeatBtn(){
       
    }
}
