//
//  WrapperAnalyticService.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 19.10.2022.
//

import Foundation
import FirebaseAnalytics

class WrapperAnalyticService: AnalyticService {
    
    private let analyticService: [AnalyticService] = [
     FireBaseAnalyticService()
    ]
    
    init() { }
    
    func logMovieDetailShowEvent(movieID: String) {
        self.analyticService.forEach { $0.logMovieDetailShowEvent(movieID: movieID)}
    }
}
