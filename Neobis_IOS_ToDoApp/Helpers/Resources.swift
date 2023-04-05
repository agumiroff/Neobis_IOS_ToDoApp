//
//  Resources.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 05.04.2023.
//

import Foundation

enum Resources {
    static var UserDefaultsStorageName = "todos"
    
    enum AppState {
        case loading
        case success
        case failure
        case edit
    }
}
