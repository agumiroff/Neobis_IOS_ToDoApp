//
//  ToDoModel.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import Foundation

struct ToDoModel: Codable, Equatable {
    let title: String
    let description: String
    let isComplete: Bool
    
    init(title: String, Description: String, isComplete: Bool) {
        self.title = title
        self.description = Description
        self.isComplete = isComplete
    }
}
