//
//  MainTableViewFooter.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 05.04.2023.
//

import Foundation
import UIKit

class MainTableViewFooter: UIView {
    
    private let footerText: UILabel = {
        let label = UILabel()
        label.text = "Создайте новую задачу \nнажав на кнопку плюс"
        label.tintColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(footerText)
        
        footerText.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        print("footer")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
