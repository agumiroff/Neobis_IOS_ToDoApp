//
//  MainCollectionViewCell.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import Foundation
import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell{
    static let cellId = "MainCollectionViewCell"
    var isChecked = false
    
    let checkMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    let infoMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.font = UIFont(name: "Helvetica", size: 24)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.font = UIFont(name: "Helvetica", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        
        
        addSubview(checkMark)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(infoMark)
        
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
        
        infoMark.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    func updateCell() {
        checkMark.image = UIImage(systemName: isChecked ? "checkmark.circle" : "circle")
    }
}
