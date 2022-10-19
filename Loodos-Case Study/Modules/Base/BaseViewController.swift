//
//  BaseViewController.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import UIKit

class BaseViewController: UIViewController {
    var isLandscapeMode: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isLandscapeMode = UIDevice.current.orientation.isLandscape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// observes device transition
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        isLandscapeMode = UIDevice.current.orientation.isLandscape
    }
    
    deinit {
        Logger.log(.deinitPage, self.description)
    }
}
