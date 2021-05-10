//
//  labelCollectionViewCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/17.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

class CalendarTagCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var tagButton: UIButton! {
        didSet {
            tagButton.titleEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        }
    }
    @IBOutlet weak var selectColorView: UIView!
    
    
    static let CellID = "CalendarTagCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            selectColorView.isHidden = isSelected
        }
    }
    
    func bindViewModel(tag : ManagedTag){
        tagButton.backgroundColor = UIColor.colorRGBHex(hex: Int(tag.color))
        tagButton.setTitle(" " + tag.name! + "    ", for: .normal)
    }
}
