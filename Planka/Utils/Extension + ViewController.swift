//
//  Extension + ViewController.swift
//  Planka
//
//  Created by Anton Vlezko on 22.10.2021.
//

import UIKit

enum NotificationConfiguration {
    case textField
    case defaultAction
    case rejectAction
    
    init() {
        self = .defaultAction
    }
}

extension UIViewController {
    func configureAddModelAlert(title: String,
                                message: String? = nil,
                                textFieldNamePlaceholder: String? = nil,
                                textFieldActionText: String? = nil,
                                rejectActionText: String? = nil,
                                completion: @escaping(NotificationConfiguration, String?) -> Void) {
        var vagetableName: String?
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        // vagetableName textfield
        alert.addTextField { (textFieldName) in
            textFieldName.placeholder = textFieldNamePlaceholder
        }
        
        alert.addAction(UIAlertAction(title: textFieldActionText,
                                      style: .default,
                                      handler: { (_) in
            let textFieldName = alert.textFields![0] // Force unwrapping because we know it exists.
            alert.dismiss(animated: true) {
                print("Text field: \(String(describing: textFieldName.text))")
                vagetableName = textFieldName.text
                completion(.textField, vagetableName)
            }
        }))
                        
        // reject action
        alert.addAction(UIAlertAction(title: rejectActionText,
                                      style: .destructive,
                                      handler: { (_) in
            alert.dismiss(animated: true)
            completion(.rejectAction, nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
