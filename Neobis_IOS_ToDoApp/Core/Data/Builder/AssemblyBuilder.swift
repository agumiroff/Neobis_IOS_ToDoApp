//
//  AssemblyBuilder.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 04.04.2023.
//

import Foundation

protocol AssemblyBuilderProtocol: AnyObject {
    func buildMainScreen(router: RouterProtocol) -> MainScreenViewController
    func buildDetailScreen(router: RouterProtocol,
                           item: ToDoModel?,
                           index: Int?) -> DetailScreenViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func buildMainScreen(router: RouterProtocol) -> MainScreenViewController {
        let presenter = MainScreenPresenter()
        let view = MainScreenViewController()
        let todoService = ToDoStorageService()
        
        presenter.view = view
        presenter.router = router
        presenter.toDoService = todoService
        view.presenter = presenter
        
        return view
    }
    
    func buildDetailScreen(router: RouterProtocol,
                           item: ToDoModel?,
                           index: Int?) -> DetailScreenViewController {
        
        let presenter = DetailScreenPresenter()
        let view = DetailScreenViewController()
        let todoService = ToDoStorageService()
        
        presenter.view = view
        presenter.router = router
        presenter.toDoService = todoService
        presenter.toDoItem = item
        presenter.toDoIndex = index
        view.presenter = presenter
        
        return view
        
    }
    
    
}
