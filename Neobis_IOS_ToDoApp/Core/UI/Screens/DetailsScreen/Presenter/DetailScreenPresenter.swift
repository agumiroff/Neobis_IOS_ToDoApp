//
//  DetailScreenPresenter.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 05.04.2023.
//

import Foundation

protocol DetailScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func cancelToDo()
    func saveToDo(title: String, description: String)
    var toDoItem: ToDoModel? { get set }
}

class DetailScreenPresenter: DetailScreenPresenterProtocol {
    weak var view: DetailScreenViewControllerProtocol?
    var toDoService: ToDoStorageServiceProtocol!
    var router: RouterProtocol?
    var toDoItem: ToDoModel?
    var toDoIndex: Int?
    
    func viewDidLoad() {
        view?.noteTitle.text = toDoItem?.title
        view?.noteDescription.text = toDoItem?.description
    }
    
    func cancelToDo() {
        router?.mainScreenRoute()
    }
    
    func saveToDo(title: String, description: String) {
        if toDoIndex == nil {
            toDoService.addTodo(toDo: ToDoModel(title: title,
                                                Description: description,
                                                isComplete: false))
        } else {
            toDoService.saveTodo(toDo: ToDoModel(title: title,
                                                 Description: description,
                                                 isComplete: toDoItem?.isComplete ?? false),
                                 index: toDoIndex ?? -1)
        }
    }
    
}
