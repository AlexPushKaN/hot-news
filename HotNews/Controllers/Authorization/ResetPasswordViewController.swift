//
//  ResetPasswordViewController.swift
//  HotNews
//
//  Created by Александр Муклинов on 07.12.2023.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    let userProfile = UserProfile.shared

    private func isValidEmail(_ email: String) -> Bool {

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfile.load()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func passwordResetButtonPressed() {
        
        guard let email = emailTextField.text, !email.isEmpty else {

            present(AlertController.showAlert(type: .error, message: "Пожалуйста, введите email."), animated: true)
            return
        }
        
        guard isValidEmail(email) else {

            present(AlertController.showAlert(type: .error, message: "Пожалуйста, введите корректный email."), animated: true)
            return
        }
        
        if emailTextField.text == userProfile.email {
            
            userProfile.delete()
            present(AlertController.showAlert(type: .warning, message: "Ваши данные безвозвратно удалены.", completionHandler: {
                
                self.navigationController?.popViewController(animated: true)
            }), animated: true)
        } else {
            
            present(AlertController.showAlert(type: .error, message: "Введен неверный email."), animated: true)
        }
    }
}
