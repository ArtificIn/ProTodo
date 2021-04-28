//
//  UICollectionViewCell+.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/26.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func handleBorder(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
}


extension UITableViewCell {
    func handleBorder(){
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
