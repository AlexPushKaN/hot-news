//
//  a.swift
//  HotNews
//
//  Created by Александр Муклинов on 08.12.2023.
//

import UIKit

enum AlertType: String {
    
    case successfully = "Успешно"
    case error = "Ошибка"
    case exit = "Выход"
}

class AlertController {
    
    static func showAlert(type: AlertType, message: String, completionHandler: (() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: type.rawValue, message: message, preferredStyle: .alert)
        switch type {
        case .exit:
            alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            alertController.addAction(UIAlertAction(title: "Выход", style: .destructive, handler: { isFinish in completionHandler?() }))
        default:
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { isFinish in completionHandler?() }))
        }
        return alertController
    }
}
