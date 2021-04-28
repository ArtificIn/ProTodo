//
//  LabelCollectionViewLayout.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/19.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation
import UIKit

class LabelCollectionViewLayout : UICollectionViewFlowLayout {
    required init(minimumInterItemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, secitonInset: UIEdgeInsets = .zero) {
        super.init()
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
        sectionInsetReference = .fromSafeArea
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttribtes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        guard scrollDirection == .vertical else { return layoutAttribtes }
        
        let cellAttributes = layoutAttribtes.filter { $0.representedElementCategory == .cell }
        for (_, attributes) in Dictionary(grouping: cellAttributes, by: { ($0.center.y / 10).rounded(.up) * 10 }) {
            var leftInset = sectionInset.left
            
            for attribute in attributes {
                attribute.frame.origin.x = leftInset
                leftInset = attribute.frame.maxX + minimumInteritemSpacing
            }
        }
        
        return layoutAttribtes
    }
}
