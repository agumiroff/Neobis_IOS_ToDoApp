//
//  DetailsScreen.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 03.04.2023.
//

import Foundation
import UIKit

protocol DetailScreenViewControllerProtocol: AnyObject {
    
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
    
    private let titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Название"
        field.backgroundColor = .white
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        field.rightViewMode = .always
        return field
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        navigationControllerSetup()
        setupViews()
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
        titleField.text = presenter?.toDoItem?.title
        textView.delegate = self
        textView.text = presenter?.toDoItem?.description
        
        view.addSubview(titleLabel)
        view.addSubview(titleField)
        view.addSubview(textView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        titleField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
        
        textView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(30)
            make.top.equalTo(titleField.snp.bottom).offset(20)
        }
    }
    
}

extension DetailScreenViewController {
    @objc func saveToDo() {
        if textView.text.isEmpty {
            return
        }
        presenter?.saveToDo(title: titleField.text ?? "",
                            description: textView.text)
        presenter?.cancelToDo()
    }
    
    @objc func cancelToDo() {
        presenter?.cancelToDo()
    }
}
