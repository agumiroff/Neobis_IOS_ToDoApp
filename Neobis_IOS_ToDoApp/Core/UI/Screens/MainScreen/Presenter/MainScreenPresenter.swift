//
//  MainPresenter.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    var mainScreenState: Resources.AppState? { get set }
    func getToDos()
    func addToDo()
    func editToDo()
    func deleteToDo()
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    weak var view: MainScreenViewControllerProtocol!
    var mainScreenState: Resources.AppState?
    
    func getToDos() {
        
    }
    
    func addToDo() {
        
    }
    
    func editToDo() {
        
    }
    
    func deleteToDo() {
        
    }
    
    
}
