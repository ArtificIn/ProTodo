//
//  MainVC.swift
//  proTodo
//
//  Created by 성다연 on 2021/01/25.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var pageCollectionView: UICollectionView! {
        didSet {
            pageCollectionView.delegate = self
            pageCollectionView.dataSource = self
        }
    }
    
    private var segmentControl : CustomSegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSegmentedControl()
    }
    
    private func createSegmentedControl(){
        segmentControl = CustomSegmentedControl(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50), buttonTitle:["Calendar", "Project"])
        segmentControl!.backgroundColor = UIColor.colorRGBHex(hex: 0x373535)
        segmentControl?.delegate = self
        view.addSubview(segmentControl!)
    }
}


extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, CustomSegmentControlDelegate {
    func customSegmentBar(scrollTo index: Int) {
        pageCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: todoCollectionViewCell.CellID, for: indexPath) as! todoCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: projectCollectionViewCell.CellID, for: indexPath) as! projectCollectionViewCell
        }
        
        return cell
    }
}


extension MainViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 50)
    }
}
