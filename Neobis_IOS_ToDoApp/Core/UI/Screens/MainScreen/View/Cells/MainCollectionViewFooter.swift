//
//  MainCollectionViewFooter.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import Foundation
import UIKit

class MainCollectionViewFooter: UIView {
    static let mainCollectionViewFooterReuseID = "MyHeaderFooterClass"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "footer"
        label.font = UIFont(name: "Helvetica", size: 24)
        return label
    }()
    
    
}
