//
//  RegistrationViewController.swift
//  HotNews
//
//  Created by Александр Муклинов on 07.12.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let userProfile = UserProfile.shared
    
    private func isValidEmail(_ email: String) -> Bool {

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func registerButtonPressed() {
        
        guard let name = loginTextField.text, !name.isEmpty else {

            present(AlertController.showAlert(type: .error, message: "Пожалуйста, введите имя."), animated: true)
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {

            present(AlertController.showAlert(type: .error, message: "Пожалуйста, введите email."), animated: true)
            return
        }
        
        guard isValidEmail(email) else {

            present(AlertController.showAlert(type: .error, message: "Пожалуйста, введите корректный email."), animated: true)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            
            present(AlertController.showAlert(type: .error, message: "Пожалуйста, введите пароль."), animated: true)
            return
        }
        
        userProfile.id = UUID().uuidString
        userProfile.name = name
        userProfile.email = email
        userProfile.password = password
        userProfile.save()
            
        if let tabBarController = storyboard?.instantiateViewController(withIdentifier: "mainTabBarController") as? UITabBarController {
            UIApplication.shared.windows.first?.rootViewController = tabBarController
        }
    }
}
