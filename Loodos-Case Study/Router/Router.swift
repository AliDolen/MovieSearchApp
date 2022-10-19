//
//  Router.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import Foundation
import UIKit

final class Router {
    
    enum Screens {
        case movieList
        case movieDetail(movieObject: MovieModel)
        
        func setViewController() -> UIViewController {
            switch self {
            case .movieList:
                return MovieSearchViewController()
            case .movieDetail(let movieObject):
                return MovieDetailViewController.build(with: movieObject)
            }
        }
    }
    
    class func navigate(to page: Screens) {
        let currentController = Router.findCurrentViewController()
        currentController?.navigationController?.pushViewController(page.setViewController(), animated: true)
    }
    
    class func findCurrentViewController(screen: Screens? = nil,
                                         baseVC: UIViewController? = nil) -> UIViewController? {
        
        if screen != nil {
            return screen?.setViewController()
        }
        let baseViewController = baseVC ?? UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController
        
        if let tab = baseViewController as? UITabBarController ,
           let selectedVC = tab.selectedViewController {
            return findCurrentViewController(baseVC: selectedVC)
        } else if let nav = baseViewController as? UINavigationController {
            return findCurrentViewController(baseVC: nav.visibleViewController)
        }
        return baseViewController
    }
}
