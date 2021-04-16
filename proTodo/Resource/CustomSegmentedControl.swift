//
//  ViewController.swift
//  proTodo
//
//  Created by 성다연 on 30/09/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

protocol CustomSegmentControlDelegate : class {
    func customSegmentBar(scrollTo index: Int)
}

class CustomSegmentedControl : UIView {
    private var buttonTitles : [String]!
    private var buttons : [UIButton] = []
    private var selectorView : UIView = UIView()
    
    weak var delegate : CustomSegmentControlDelegate?
    
    var textColor:UIColor = UIColor.colorRGBHex(hex: 0xc4c4c4)
    var selectorViewColor:UIColor = .white
    var selectortextColor:UIColor = .white
    var buttonNumber : Int = 0
    
    private func configStackView(){
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView(){
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
        
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        selectorView.widthAnchor.constraint(equalToConstant: selectorWidth).isActive = true
        selectorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
       
    }
    
    private func createButton(){
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
            
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectortextColor, for: .normal)
    }
    
    @objc func buttonAction(sender: UIButton){
        for (buttonIndex, btn) in buttons.enumerated() {
            buttonNumber = buttonIndex
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width / CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectortextColor, for: .normal)
                delegate?.customSegmentBar(scrollTo: buttonIndex)
            }
        }
    }
    
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    convenience init(frame: CGRect, buttonTitle:[String]) {
        self.init(frame:frame)
        self.buttonTitles = buttonTitle
    }
    override func draw(_ rect: CGRect){
        super.draw(rect)
        updateView()
    }
    func setButtonTitles(buttonTitles:[String]){
        self.buttonTitles = buttonTitles
        updateView()
    }
    
}
