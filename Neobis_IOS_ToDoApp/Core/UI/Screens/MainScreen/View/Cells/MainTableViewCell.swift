//
//  MainTableViewCell.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 04.04.2023.
//

import Foundation
import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    static let cellId = "MainTableViewCell"
    var isChecked = false
    
    private var checkMark: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .orange
        var configuration = UIButton.Configuration.borderless()
        configuration.background.backgroundColor = .systemBackground
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15,
                                                              bottom: 15, trailing: 15)
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        button.addTarget(self, action: #selector(check), for: .touchUpInside)
        return button
    }()
    
    let infoMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.font = UIFont(name: "Helvetica", size: 24)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.font = UIFont(name: "Helvetica", size: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "MainTableViewCell")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        selectionStyle = .none
        accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        
        self.contentView.addSubview(checkMark)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        checkMark.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(checkMark.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(checkMark.snp.right).offset(10)
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        
    }
    
    @objc func check(sender: UIButton) {
        if !isEditing {
            isChecked.toggle()
            sender.setImage(UIImage(systemName: isChecked ? "checkmark.circle" : "circle"), for: .normal)
        }
        
    }
    
}

