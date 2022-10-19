//
//  MovieCollectionViewCellViewModel.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 17.10.2022.
//

import Foundation

protocol MovieCollectionViewCellViewModelProtocol {
    func prepeareUI()
}

class MovieCollectionViewCellViewModel {
    
    weak var interface: MovieCollectionViewCellInterface?
    var movieObject: MovieModel?
    
    init(view: MovieCollectionViewCellInterface?, movieObject: MovieModel?) {
        self.interface = view
        self.movieObject = movieObject
    }
}

extension MovieCollectionViewCellViewModel: MovieCollectionViewCellViewModelProtocol {
    func prepeareUI() {
        guard let movieObject = movieObject else {
            Logger.log(.error, "Movie object is not handled")
            return
        }
        interface?.updateUI(with: movieObject)
    }
}
