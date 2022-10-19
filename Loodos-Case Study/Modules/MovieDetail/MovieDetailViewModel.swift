//
//  MovieDetailViewModel.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 17.10.2022.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    func prepareUI()
    func logShowEvent()
}

final class MovieDetailViewModel {
    
    weak var interface: MovieDetailViewControllerInterface?
    var movieObject: MovieModel?
    private var analyticService: AnalyticService?
    
    // MARK: - Initializer
    init(interface: MovieDetailViewControllerInterface?, movieObject: MovieModel?, analyticService: AnalyticService? = nil) {
        self.interface = interface
        self.movieObject = movieObject
        self.analyticService = analyticService
    }
}

// MARK: - Implementation of MovieDetailViewController
extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    func prepareUI() {
        guard let movieObject = movieObject else {
            Logger.log(.error, "Movie Object not handled on detail page")
            return
        }
        interface?.updateUI(with: movieObject)
    }
    
    func logShowEvent() {
        self.analyticService?.logMovieDetailShowEvent(movieID: String(movieObject?.id ?? 0))
    }
    
}
