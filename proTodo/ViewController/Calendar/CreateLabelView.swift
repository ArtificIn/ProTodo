//
//  createLabelView.swift
//  proTodo
//
//  Created by 성다연 on 2021/04/18.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

class CreateLabelView: UIView {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldBackView: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
//            collectionView.delegate = self
//            collectionView.dataSource = self
        }
    }
    @IBAction func cancleButton(_ sender: UIButton) {
        removeFromSuperview()
    }
    @IBAction func completeButton(_ sender: UIButton) {
        guard let text = textField.text,
              let c = color else { return }
        newTag = Tag(id: 0, name: text, color: c)
        TagModel.shared.tagList.append(newTag!)
        removeFromSuperview()
    }
    
    var newTag : Tag?
    var color : Int?
    
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        let view = viewFromNib()
        view.frame = bounds
        
        view.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        addSubview(view)
    }
    
    private func viewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CreateLabelView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}

//
//extension CreateLabelView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Colors.arrays.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createLabelCollectionViewCell.cellID, for: indexPath) as! createLabelCollectionViewCell
//        cell.bindViewModel(color: Colors.arrays[indexPath.row])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        color = Colors.arrays[indexPath.row]
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 42, height: 42)
//    }
//}

