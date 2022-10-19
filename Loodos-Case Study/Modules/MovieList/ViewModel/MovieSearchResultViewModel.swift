//
//  MovieDetailViewModel.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 17.10.2022.
//

import Foundation
import Combine

protocol MovieSearchResultViewModelProtocol: AnyObject {
    var movieList: [MovieModel]? { get }
    func fetchMovieList(query: String)
    func showAlert(title: String?, message: String?)
    func numberOfMovieList() -> Int
    func getMovieObject(row: Int) -> MovieModel?
    func movieSelected(row: Int)
}

final class MovieSearchResultViewModel {
    
    weak var view: MovieListViewInterface?
    var networkService: NetworkServiceProtocol?
    var movieList: [MovieModel]?
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Initializer
    init(view: MovieListViewInterface? = nil, networkService: NetworkServiceProtocol? = nil ) {
        self.view = view
        self.networkService = networkService
    }
}

extension MovieSearchResultViewModel: MovieSearchResultViewModelProtocol {
    
    func fetchMovieList(query: String) {
        networkService?.fetchSearchMovies(with: query)
            .sink{ [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    Logger.log(.error, "oops got an error \(error.localizedDescription)")
                    self?.showAlert(title: "ERROR ❌", message: error.localizedDescription)
                case .finished:
                    Logger.log(.success, "fetch movie list is finished")
                    self?.view?.movieListFetched()
                }
            } receiveValue: { [weak self] movieResponse in
                self?.movieList = movieResponse.results
            }.store(in: &cancellable)
    }
    
    func numberOfMovieList() -> Int {
        movieList?.count ?? 0
    }
    
    func getMovieObject(row: Int) -> MovieModel? {
        movieList?[safeIndex: row]
    }
    
    func movieSelected(row: Int) {
        guard let movieObject = getMovieObject(row: row) else {
            Logger.log(.error, "Movielist view model selected object is nil")
            return
        }
        navigateToMovieDetail(with: movieObject)
    }
    
    func showAlert(title: String?, message: String?) {
        self.view?.showNotification(title: title, message: message)
    }
    
    func navigateToMovieDetail(with selectedMovie: MovieModel) {
        Router.navigate(to: .movieDetail(movieObject: selectedMovie))
    }
    
}
