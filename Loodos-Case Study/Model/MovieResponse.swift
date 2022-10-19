//
//  MovieResponse.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import Foundation

// MARK: - Movie Response
struct MovieResponse: Codable {
    let results: [MovieModel]?
}

