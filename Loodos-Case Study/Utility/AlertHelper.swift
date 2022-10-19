//
//  AlertHelper.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import Foundation
import UIKit

protocol AlertHelper {
    func showNotification(title: String?, message: String?)
}

extension AlertHelper where Self: UIViewController {
    
    func showNotification(title: String?, message: String?) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
            self?.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
