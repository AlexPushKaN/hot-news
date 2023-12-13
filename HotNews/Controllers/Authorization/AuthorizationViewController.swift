//
//  AuthorizationViewController.swift
//  HotNews
//
//  Created by Александр Муклинов on 07.12.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let userProfile = UserProfile.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfile.load()
        hideKeyboardWhenTappedAround()
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func showMainTabBarController() {
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: "mainTabBarController") as! MainTabBarController
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    @IBAction func entranceButtonPressed() {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            present(AlertController.showAlert(type: .error, message: "Пожалуйста, введите почту."), animated: true)
            return
        }
        
        guard isValidEmail(email) else {
            present(AlertController.showAlert(type: .error, message: "Пожалуйста, проверьте корректность ввода почты."), animated: true)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            present(AlertController.showAlert(type: .error, message: "Пожалуйста, введите пароль."), animated: true)
            return
        }
        
        if emailTextField.text == userProfile.email && passwordTextField.text == userProfile.password { showMainTabBarController() }
        else { present(AlertController.showAlert(type: .error, message: "Указана неверная почта или пароль."), animated: true) }
    }
    
    
    @IBAction func registerButtonPressed() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "registrationViewController") as! RegistrationViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func passwordResetButtonPressed() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "resetPasswordViewController") as! ResetPasswordViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func unwindToAuthorizationController(_ sender: UIStoryboardSegue) {}
}
