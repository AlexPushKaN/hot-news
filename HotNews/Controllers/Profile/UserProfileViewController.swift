//
//  UserProfileViewController.swift
//  HotNews
//
//  Created by Александр Муклинов on 08.12.2023.
//

import UIKit
import SnapKit

class UserProfileViewController: UIViewController {
    
    let userProfile = UserProfile.shared
    var navigationBarHeight: CGFloat = 0.0
    
    lazy var userProfileImageView: UIImageView = {
        
        let imageView = UIImageView()
        addAndConfigure(view: imageView)
        imageView.snp.makeConstraints { make in

            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(250.0)
        }
        
        return imageView
    }()
    
    lazy var nameTextField: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Имя"
        addAndConfigure(view: textField)
        textField.snp.makeConstraints { make in

            make.top.equalTo(userProfileImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44.0)
        }
        
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        addAndConfigure(view: textField)
        textField.snp.makeConstraints { make in

            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44.0)
        }
        
        return textField
    }()
    
    lazy var exitButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.addTarget(self, action: #selector(backToAuthorizationViewController), for: .touchUpInside)
        
        addAndConfigure(view: button)
        button.snp.makeConstraints { make in

            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8313708305, green: 0.8313739896, blue: 0.8999735117, alpha: 1)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        userProfileImageView.image = UIImage(named: userProfile.photo)
        nameTextField.text = userProfile.name.isEmpty ? "" : userProfile.name
        emailTextField.text = userProfile.email
        exitButton.setTitle("Выйти", for: .normal)
    }

    private func addAndConfigure(view: UIView) {

        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        if view is UIButton { return }
        else { view.isUserInteractionEnabled = false }
    }
    
    @objc func backToAuthorizationViewController() {
        
        present(AlertController.showAlert(type: .exit, message: "Вы уверены, что хотите выйти из аккаунта?", completionHandler: {
            self.navigationController?.popToRootViewController(animated: true)
        }), animated: true)
    }
}
