//
//  ViewController.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {
    
    //MARK: Properties
    var mainCollectionView: UICollectionView = {
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: listLayout)
        collection.backgroundColor = UIColor.clear
        collection.register(MainCollectionViewCell.self,
                            forCellWithReuseIdentifier: MainCollectionViewCell.cellId)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mainCollectionSetup()
    }
    
}
//MARK: CollectionView methods
extension MainScreenViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout
{
    func mainCollectionSetup() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.showsVerticalScrollIndicator = false
        mainCollectionView.showsHorizontalScrollIndicator = false
//        mainCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10,
//                                                       bottom: 0, right: 10)
        
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Items in section. There should be [arrayWithData].count
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //put your cell here
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellId, for: indexPath) as? MainCollectionViewCell
        else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //size for collectionViewCell
        CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width,
               height: 80)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        mainCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //space between cells
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //logic for selection on item
        print("someLogic")
        guard let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell
        else { return }
        cell.isChecked.toggle()
        cell.updateCell()
    }
    
    
}

//MARK: Views setup
extension MainScreenViewController {
    
    
    
}
