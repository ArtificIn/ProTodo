//
//  CreateVC.swift
//  proTodo
//
//  Created by 성다연 on 03/12/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit


class CreateVC: UIViewController {
    @IBOutlet weak var ColorCollectionView: UICollectionView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var selectedColorView: UIView!
    
    @IBOutlet weak var collectionTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewTopConstraint: NSLayoutConstraint!
    
    var selectColor = 0xffffff
    var isColorViewAppear = false
    
    let items = [
        0xfff8b6, 0xffe4a3, 0xffbd91, 0xff8d71, 0xff707e,
        0xffc100, 0xff9a00, 0xff7400, 0xff4d00, 0xff0000,
        0xcef19d, 0xa6dba7, 0x77bd98, 0x398684, 0x094869,
        0xdaf8e3, 0x97ebdb, 0x00c2c7, 0x0086ad, 0x005582,
        0xfadbe0, 0xeaadbd, 0xb88a9f, 0x876880, 0x554562]
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.touchSetting()
        self.TextFieldSetting()
    }
}


// logic code
extension CreateVC {
    func touchSetting(){
        completeBtn.addTarget(self, action: #selector(completeAction), for: .touchUpInside)
        
        let tapColorView = UITapGestureRecognizer(target: self, action: #selector(touchColorView))
        colorView.isUserInteractionEnabled = true
        colorView.addGestureRecognizer(tapColorView)
    }
    
    func TextFieldSetting(){
        textField.attributedPlaceholder = NSAttributedString(string: "할 일을 입력하세요.",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.addTarget(self, action: #selector(keyboard), for: .touchDown)
    }
    
    @objc func completeAction(){
        guard let memo = textField.text else {return}
        //guard let
        
        let newTodo = Todo(memo: memo, color: selectColor, update: Date())
        
        Database.arrayList.append(newTodo)
        Database.saveData()
        presentingViewController?.viewWillAppear(true)
        // must insert save code
        dismiss(animated: true)
    }
    
    @objc func touchColorView(){
        isColorViewAppear = !isColorViewAppear

        if isColorViewAppear {
            self.collectionTopConstraint.constant = 145
            self.textViewTopConstraint.constant = 153 + ColorCollectionView.frame.height
        } else {
            self.collectionTopConstraint.constant = -146
            self.textViewTopConstraint.constant = 153
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {self.view.layoutIfNeeded()})
    }
    
    @objc func keyboard(){
        if isColorViewAppear == true {
            registerForKeyboard()
        } else {
            removeForKeyboard()
        }
    }
}


extension CreateVC : UITextFieldDelegate {

}


// collectionView control
extension CreateVC : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = ColorCollectionView.cellForItem(at: indexPath)
        selectColor = items[indexPath.item]
        selectedColorView.backgroundColor = UIColor.colorRGBHex(hex: selectColor)
        // int -> hex
        // var st = NSString(format: "%02X", selectColor)
        cell?.backgroundColor = UIColor.darkGray
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = ColorCollectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.colorRGBHex(hex: 0x373535)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ColorCollectionView.dequeueReusableCell(withReuseIdentifier: "colorcollectcell", for: indexPath) as! ColorCollectCell
        
        cell.layer.cornerRadius = 17
        cell.colorImg.backgroundColor = UIColor.colorRGBHex(hex: items[indexPath.item])
        selectColor = indexPath.item
        
        return cell
    }
}
