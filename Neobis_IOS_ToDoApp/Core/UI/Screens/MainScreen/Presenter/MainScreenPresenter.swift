//
//  MainPresenter.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import Foundation
import Combine

protocol MainScreenPresenterProtocol: AnyObject {
    func getToDos()
    func addToDo()
    func editToDoList(toDoList: [ToDoModel])
    func deleteToDo(index: Int)
    func viewDidLoad()
    func showDetails(item: ToDoModel, index: Int)
    func editToDo(toDo: ToDoModel, index: Int)
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    weak var view: MainScreenViewControllerProtocol?
    var toDoService: ToDoStorageServiceProtocol!
    var router: RouterProtocol?
    @Published var toDos = [ToDoModel]()
    var cancellables = Set<AnyCancellable>()
    
    func viewDidLoad() {
        getToDos()
        view?.toDos = toDos
        
        $toDos
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { toDos in
                self.view?.toDos = toDos
                self.view?.updateUI()
            })
            .store(in: &cancellables)
        
    }
    
    
    func getToDos() {
        toDoService?.getToDos(completion: {[weak self] toDos in
            self?.toDos = toDos
        })

    }
    
    func addToDo() {
        router?.detailScreenRoute(item: nil, index: nil)
        getToDos()
    }
    
    func editToDoList(toDoList: [ToDoModel]) {
        toDoService.editToDoList(toDoList: toDoList)
    }
    
    func deleteToDo(index: Int) {
        toDoService.deleteToDo(index: index)
        getToDos()
    }
    
    func showDetails(item: ToDoModel, index: Int) {
        router?.detailScreenRoute(item: item, index: index)
    }
    
    func editToDo(toDo: ToDoModel, index: Int) {
        toDoService.saveTodo(toDo: toDo, index: index)
        getToDos()
    }
    
    deinit {
        print("presenter deinit")
        
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
}
