//
//  CustomTabbar.swift
//  proTodo
//
//  Created by 성다연 on 08/01/2020.
//  Copyright © 2020 성다연. All rights reserved.
//
import UIKit
import Foundation

protocol CustomMenuBarDelegate : class{
    func customMenuBar(scrollTo index: Int)
}

class CustomMenuBar: UIView {
    weak var delegate: CustomMenuBarDelegate?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.colorRGBHex(hex: 0x373535)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: )has not been implemented")
    }
    
    var indicatorView: UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.colorRGBHex(hex: 0xebeaea)
        return view
    }
}

extension CustomMenuBar : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCollectionCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.customMenuBar(scrollTo: indexPath.row)
    }
}
