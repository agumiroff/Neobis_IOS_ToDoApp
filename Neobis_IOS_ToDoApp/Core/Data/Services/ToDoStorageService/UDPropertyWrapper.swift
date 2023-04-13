//
//  UDPropertyWrapper.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 05.04.2023.
//

import Foundation


@propertyWrapper
struct Storage {
    private let key: String
    private let defaults = UserDefaults.standard
    
    init(key: String) {
        self.key = key
    }
    
    var wrappedValue: [ToDoModel] {
        
        get {
            if let data = defaults.value(forKey: key) as? Data {
                do {
                    let todos = try PropertyListDecoder().decode([ToDoModel].self, from: data)
                    
                    return todos
                } catch {
                    print(error)
                    return []
                }
            } else {
                return []
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: key)
                print("set")
            }
        }
        
    }
}
