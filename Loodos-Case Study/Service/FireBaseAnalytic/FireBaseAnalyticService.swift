//
//  FireBaseAnalyticService.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 19.10.2022.
//

import Foundation
import FirebaseAnalytics

protocol AnalyticService {
    func logMovieDetailShowEvent(movieID: String)
}

class FireBaseAnalyticService: AnalyticService {
    private static let filmDetailEventKey = "film_Detail_Shown"
    private static let movieKey = "id"
    
    func logMovieDetailShowEvent(movieID: String) {
        Analytics.logEvent(
            FireBaseAnalyticService.filmDetailEventKey,
            parameters: [FireBaseAnalyticService.movieKey: movieID]
        )
    }
}
