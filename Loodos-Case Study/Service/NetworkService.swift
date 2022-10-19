//
//  NetworkService.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 15.10.2022.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetchSearchMovies(with querry: String) -> AnyPublisher<MovieResponse, NetworkError>
}

class NetworkService: NetworkServiceProtocol {
    
    private var networkRequest: Requestable
    private var environment: Environment = .development
    
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func fetchSearchMovies(with querry: String) -> AnyPublisher<MovieResponse, NetworkError> {
        let endpoint = NetworkServiceEndpoint.searchMovieList(querry: querry)
        let request = endpoint.createRequest(environment: self.environment)
        return self.networkRequest.request(request)
    }
    
}
