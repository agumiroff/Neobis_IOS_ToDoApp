//
//  MainCollectionViewCell.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import Foundation
import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewListCell{
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
        backgroundColor = .clear
        tintColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        let disclosureIndicator = UICellAccessory.disclosureIndicator(displayed: .whenNotEditing,
                                             options: .init(isHidden: false,
                                                            tintColor: .systemGray4))
        let reorder = UICellAccessory.reorder(displayed: .whenEditing)
        let delete = UICellAccessory.delete(displayed: .whenEditing,
                                               options: .init(isHidden: false,
                                                              tintColor: .red))
        let info = UICellAccessory.detail(displayed: .whenNotEditing,
                                          options: .init(isHidden: false,
                                                         tintColor: .systemBlue))
        let checkmark = UICellAccessory.multiselect(displayed: .whenNotEditing, options: .init(isHidden: false, tintColor: .systemOrange, backgroundColor: .white))
        
        
        accessories = [checkmark, reorder, disclosureIndicator, delete, info]
        
        addSubview(checkMark)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        checkMark.isHidden = true
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
    
    func updateCell() {
        checkMark.image = UIImage(systemName: isChecked ? "checkmark.circle" : "circle")
    }
}
