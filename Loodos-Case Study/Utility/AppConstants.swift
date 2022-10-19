//
//  AppConstants.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import UIKit

struct AppConstants {
    
    /// Screen Constants
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    static let alertDuration: Double = 1.0
    
    /// splash screen image logo
    static let splashLogo = "loodos"
    
    /// base image url
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    /// image download constants
    static let imageQueue = OperationQueue()
    static let imageCache = NSCache<NSString, UIImage>()
    static let placeHolderImage = UIImage(systemName: "xmark.octagon.fill")
    
    /// color constants
    static let cellBackgroundColor = UIColor(redColor: 20, greenColor: 20, blueColor: 20, alpha: 1)
}
