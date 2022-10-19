//
//  UIColor + extension.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(redColor: CGFloat, greenColor: CGFloat, blueColor: CGFloat, alpha: CGFloat ) {
        self.init(red: redColor / 255, green: greenColor / 255, blue: blueColor / 255, alpha: alpha)
    }
}
