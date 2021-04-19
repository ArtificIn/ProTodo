//
//  createLabelCollectionViewCell.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/18.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

class createLabelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!
    
    static let cellID = "createLabelCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(color: Int) {
        colorView.backgroundColor = UIColor.colorRGBHex(hex: color)
    }
}
