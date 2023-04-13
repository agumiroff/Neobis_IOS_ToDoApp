//
//  DetailsScreen.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import Foundation
import UIKit

protocol DetailScreenViewControllerProtocol: AnyObject {
    var noteTitle: UITextField { get set }
    var noteDescription: UITextView { get set }
}

class DetailScreenViewController: UIViewController,
                                  DetailScreenViewControllerProtocol,
                                  UITextViewDelegate {
    
    var presenter: DetailScreenPresenterProtocol?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Название"
        return label
    }()
    
    var noteTitle: UITextField = {
        let field = UITextField()
        field.placeholder = "Название"
        field.backgroundColor = .white
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        field.rightViewMode = .always
        return field
    }()
    
    var noteDescription: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        navigationControllerSetup()
        setupViews()
        presenter?.viewDidLoad()
    }
    
    func navigationControllerSetup() {
        navigationController?.isNavigationBarHidden = false
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelToDo))
        navigationItem.leftBarButtonItem?.tintColor = .red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                            image: .none,
                                                            target: self,
                                                            action: #selector(saveToDo))
    }
    
    
    private func setupViews() {
        noteDescription.delegate = self
        
        view.addSubview(titleLabel)
        view.addSubview(noteTitle)
        view.addSubview(noteDescription)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        noteTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
        
        noteDescription.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(30)
            make.top.equalTo(noteTitle.snp.bottom).offset(20)
        }
    }
    
    @objc func saveToDo() {
        if noteDescription.text.isEmpty {
            return
        }
        presenter?.saveToDo(title: noteTitle.text ?? "",
                            description: noteDescription.text)
        presenter?.cancelToDo()
    }
    
    @objc func cancelToDo() {
        presenter?.cancelToDo()
    }
}
