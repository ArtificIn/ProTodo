//
//  MainVC.swift
//  proTodo
//
//  Created by 성다연 on 2021/01/25.
//  Copyright © 2021 성다연. All rights reserved.
//

import UIKit


protocol MainViewControllerDelegate  {
    func presentProjectBoardViewController(index: Int)
    func refreshMainViewController()
}

class MainViewController: UIViewController {
    @IBOutlet weak var pageCollectionView: UICollectionView! {
        didSet {
            pageCollectionView.delegate = self
            pageCollectionView.dataSource = self
        }
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if segmentNumber == 0 {
            let nextVC = storyboard.instantiateViewController(identifier: CalendarAddTodoViewController.cellID) as CalendarAddTodoViewController
           present(nextVC, animated: true)
        } else {
            let nextVC = storyboard.instantiateViewController(identifier: ProjectCreateViewController.cellID) as ProjectCreateViewController
            nextVC.delegate = self
            present(nextVC, animated: true)
        }
    }
    
    private var segmentControl : CustomSegmentedControl?
    private var segmentNumber = 0
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var projectModels : [ManagedProject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
        segmentNumber = index
        pageCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTodoCollectionViewCell.cellID, for: indexPath) as! MainTodoCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainProjectCollectionViewCell.CellID, for: indexPath)
                as! MainProjectCollectionViewCell
            cell.delegate = self
            return cell
        }
    }
}


extension MainViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 50)
    }
}


extension MainViewController : MainViewControllerDelegate {
    func presentProjectBoardViewController(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: ProjectBoardViewController.cellID) as ProjectBoardViewController
        nextVC.project = ProjectModel.shared.list[index]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func refreshMainViewController() {
        print("refresh!")
        pageCollectionView.reloadData()
    }
}
