//
//  ViewController.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import UIKit
import SnapKit

protocol MainScreenViewControllerProtocol: AnyObject {
    
}

class MainScreenViewController: UIViewController,
                                    MainScreenViewControllerProtocol {
    
    //MARK: Properties
    private var mainCollectionView: UICollectionView!
    
    private var editToDoButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "pencil")
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .green
        configuration.background.image = image?.withTintColor(.white,
                                                              renderingMode: .alwaysOriginal)
        configuration.background.imageContentMode = .scaleAspectFit
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15,
                                                              bottom: 15, trailing: 15)
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        button.addTarget(self, action: #selector(editToDo), for: .touchUpInside)
        return button
    }()
    
    private var addToDoButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus")
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .blue
        configuration.background.image = image?.withTintColor(.white,
                                                              renderingMode: .alwaysOriginal)
        configuration.background.imageContentMode = .scaleAspectFit
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15,
                                                              bottom: 15, trailing: 15)
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        button.addTarget(self, action: #selector(addToDo), for: .touchUpInside)
        return button
    }()
    
    //MARK: Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionVIew()
        mainCollectionSetup()
        setupButtons()
    }
    
}
//MARK: CollectionView methods
extension MainScreenViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout
{
  
    
    func configureCollectionVIew() {
        
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = { indexPath in
            let deleteAction = UIContextualAction(style: .destructive, title: "delete") {
                [weak self] action, view, completion in
                print(indexPath)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        let listLayout = UICollectionViewCompositionalLayout.list(using: config)
        mainCollectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: listLayout)
        mainCollectionView.backgroundColor = UIColor.clear
        mainCollectionView.allowsMultipleSelection = true
        mainCollectionView.register(MainCollectionViewCell.self,
                                    forCellWithReuseIdentifier: MainCollectionViewCell.cellId)
        mainCollectionView.register(MainCollectionViewFooter.self,
                                    forSupplementaryViewOfKind: "Footer",
                                    withReuseIdentifier: MainCollectionViewFooter.mainCollectionViewFooterReuseID)
    }
    
    func mainCollectionSetup() {
        
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.showsVerticalScrollIndicator = false
        mainCollectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell
        else { return }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
        print(kind)
        footerView.backgroundColor = UIColor.green
        return footerView
    }
    
    
}

//MARK: Views setup
extension MainScreenViewController {
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.mainCollectionView.isEditing = editing
    }
    
    
    
    func setupButtons() {
        
        mainCollectionView.addSubview(editToDoButton)
        mainCollectionView.addSubview(addToDoButton)
        
        editToDoButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).inset(20)
            make.bottom.equalTo(addToDoButton.snp.top).offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        addToDoButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).inset(20)
            make.bottom.equalTo(view.snp.bottom).inset(40)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
}

//MARK: Methods
extension MainScreenViewController {
    
    @objc func addToDo(){
        print("add")
        self.setEditing(true, animated: true)
    }
    
    @objc func editToDo(){
        print("edit")
    }

}
