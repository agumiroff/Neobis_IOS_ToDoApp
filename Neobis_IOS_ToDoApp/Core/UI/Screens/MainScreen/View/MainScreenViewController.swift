//
//  ViewController.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import UIKit
import SnapKit

protocol MainScreenViewControllerProtocol: AnyObject {
    var toDos: [ToDoModel] { get set }
    func updateUI()
}

class MainScreenViewController: UIViewController,
                                MainScreenViewControllerProtocol {
    
    //MARK: Properties
    var toDos = [ToDoModel]()
    var isEditingTableView = false
    var presenter: MainScreenPresenterProtocol?
    var isComplete = false
    
    private let footer = MainTableViewFooter()
    
    private var mainTableView: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self,
                       forCellReuseIdentifier: MainTableViewCell.cellId)
        return table
    }()
    
    private var editToDoButton: UIButton!
    private var addToDoButton: UIButton!
    
    //MARK: Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter?.viewDidLoad()
        navigationControllerSetup()
        tableViewConfig()
        setupButtons()
    }
    
    
    func navigationControllerSetup() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupButtons() {
        addToDoButton = CustomElements.createButton(systemImage: "plus",
                                                    color: .systemGreen)
        editToDoButton = CustomElements.createButton(systemImage: "pencil",
                                                     color: .systemBlue)
        
        addToDoButton.addTarget(self, action: #selector(addToDo), for: .touchUpInside)
        editToDoButton.addTarget(self, action: #selector(editToDoList), for: .touchUpInside)
        
        view.addSubview(mainTableView)
        mainTableView.addSubview(editToDoButton)
        mainTableView.addSubview(addToDoButton)
        
        mainTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
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
    
    func updateUI() {
        mainTableView.reloadData()
        mainTableView.layoutIfNeeded()
    }
    
    @objc func addToDo(){
        presenter?.addToDo()
    }
    
    @objc func editToDoList(){
        isEditingTableView.toggle()
        self.setEditing(isEditingTableView, animated: true)
        editToDoButton.setImage(UIImage(systemName: isEditingTableView ? "xmark" : "pencil"),
                                for: .normal)
        addToDoButton.isHidden = isEditingTableView
    }
    
    @objc func check(sender: UIButton) {
        if !isEditing {
            print("check \(isComplete)")
            let index = sender.tag
            isComplete = toDos[index].isComplete
            isComplete.toggle()
            let toDo = ToDoModel(title: toDos[index].title,
                                 Description: toDos[index].description,
                                 isComplete: isComplete)
            print(toDo)
            presenter?.editToDo(toDo: toDo,
                                index: sender.tag)
        }
        
    }
    
}

//MARK: TableView methods
extension MainScreenViewController: UITableViewDelegate,
                                    UITableViewDataSource
{
    
    func tableViewConfig() {
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.allowsMultipleSelection = true
        mainTableView.tableFooterView = footer
        footer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    //items in tableView count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDos.count
    }
    
    //cell setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId) as? MainTableViewCell else { return UITableViewCell()}
        cell.titleLabel.text = toDos[indexPath.row].title
        cell.descriptionLabel.text = toDos[indexPath.row].description
        cell.isComplete = toDos[indexPath.row].isComplete
        cell.updateCellCheckMark()
        cell.checkMark.addTarget(self, action: #selector(check), for: .touchUpInside)
        cell.checkMark.tag = indexPath.row
        return cell
    }
    
    //can move row: Bool
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    //drag and swap items in tableView
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        toDos.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        presenter?.editToDoList(toDoList: toDos)
    }
    
    
    //delete tableView row
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            presenter?.deleteToDo(index: indexPath.row)
        }
    }
    
    //action on row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showDetails(item: toDos[indexPath.row], index: indexPath.row)
    }
    
    //function for editMode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        mainTableView.isEditing = editing
    }
}
