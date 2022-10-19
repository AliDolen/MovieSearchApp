//
//  MovieModel.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import Foundation

// MARK: - Movie Model
struct MovieModel: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case media_type
        case original_name
        case original_title
        case poster_path
        case overview
        case vote_count
        case release_date
        case vote_average
    }
}
