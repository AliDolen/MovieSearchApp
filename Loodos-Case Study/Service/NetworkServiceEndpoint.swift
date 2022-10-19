//
//  NetworkServiceEndpoint.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 15.10.2022.
//

import Foundation

struct Constants {
    static let APIKey = "e91439e7ba17b8aa0f34d3f239ee24cc"
}

public typealias Headers = [String: String]

enum NetworkServiceEndpoint {
    
    // organize all the endpoints here for clarity
    case searchMovieList(querry: String)
    
    // default value for timeout but can be different for each
    var requestTimeOut: Int {
        return 20
    }
    
    // type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .searchMovieList:
            return .GET
        }
    }
    
    // compose the network request
    func createRequest(token: String? = nil, environment: Environment) -> NetworkRequest {
        var headers: Headers = [:]
        headers["content-type"] = "application/json"
        headers["Authorization"] = "Bearear \(token ?? "")" // Our Service does not need API Key
        return NetworkRequest(url: getUrl(from: .development), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        default:
            return nil
        }
    }
    
    // compose urls for each request
    func getUrl(from environment: Environment) -> String {
        let baseUrl = environment.networkServiceEnvironment
        switch self {
        case .searchMovieList(let querry):
            return "\(baseUrl)/3/search/movie?api_key=\(Constants.APIKey)&query=\(querry)"
        }
    }
}

public enum Environment: String, CaseIterable {
    case development
    case production
}

extension Environment {
    var networkServiceEnvironment: String {
        switch self {
        case .development:
            return "https://api.themoviedb.org"
        case .production:
            return ""
        }
    }
}
