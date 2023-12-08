//
//  a.swift
//  HotNews
//
//  Created by Александр Муклинов on 08.12.2023.
//

import UIKit

enum AlertType: String {
    
    case error = "Ошибка"
    case warning = "Внимание"
}

class AlertController {
    
    static func showAlert(type: AlertType, message: String, completionHandler: (() -> Void)? = nil) -> UIAlertController {
        
        let alertController = UIAlertController(title: type.rawValue, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { isFinish in completionHandler?() }))

        return alertController
    }
}
