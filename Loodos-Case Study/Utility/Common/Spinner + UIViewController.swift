//
//  Spinner + UIViewController.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 18.10.2022.
//

import Foundation
import UIKit

fileprivate var spinnerView: UIView?

extension UIViewController {
    
    func showSpinner(onView: UIView) {
        let view = UIView.init(frame: onView.bounds)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        
        DispatchQueue.main.async {
            view.addSubview(activityIndicator)
            onView.addSubview(view)
        }
        spinnerView = view
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            spinnerView?.removeFromSuperview()
            spinnerView = nil
        }
    }
}
