//
//  CustomElements.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 05.04.2023.
//

import Foundation
import UIKit

class CustomElements {
    static func createButton(systemImage: String, color: UIColor) -> UIButton {
        let button = UIButton()
        let image = UIImage(systemName: systemImage)
        var configuration = UIButton.Configuration.filled()
        button.setImage(image, for: .normal)
        configuration.baseBackgroundColor = color
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15,
                                                              bottom: 15, trailing: 15)
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        return button
    }
}
