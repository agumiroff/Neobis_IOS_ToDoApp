//
//  ToDoService.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import Foundation

struct ToDoStorage {
    
    @Storage(key: "todos")
    static var todos: [ToDoModel]
    
}

protocol ToDoStorageServiceProtocol: AnyObject {
    func addTodo(toDo: ToDoModel)
    func getToDos(completion: @escaping ([ToDoModel]) -> Void)
    func saveTodo(toDo: ToDoModel, index: Int)
    func deleteToDo(index: Int)
    func editToDoList(toDoList: [ToDoModel])
}



class ToDoStorageService: ToDoStorageServiceProtocol {
    
    func addTodo(toDo: ToDoModel) {
        ToDoStorage.todos.insert(toDo, at: 0)
    }
    
    func getToDos(completion: @escaping ([ToDoModel]) -> Void) {
        completion(ToDoStorage.todos)
    }
    
    func saveTodo(toDo: ToDoModel, index: Int) {
        ToDoStorage.todos[index] = toDo
    }
    
    func deleteToDo(index: Int) {
        ToDoStorage.todos.remove(at: index)
    }
    
    func editToDoList(toDoList: [ToDoModel]) {
        ToDoStorage.todos = toDoList
    }
    
}
