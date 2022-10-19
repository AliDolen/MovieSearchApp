//
//  NetworkManager.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 15.10.2022.
//

import Foundation
import Combine

protocol Requestable {
    var requestTimeOut: Float { get }
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}

public class NativeRequestable: Requestable {
    public var requestTimeOut: Float = 30
    
    func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError> where T : Decodable, T : Encodable {
        let sessionConfing = URLSessionConfiguration.default
        sessionConfing.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
        
        guard let url = URL(string: req.url) else {
            // return a fail publisher if the url is invalid
            Logger.log(.error, "URL is invalid")
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL("invalid URL"))
            )
        }
        
        // we use dataTaskPublisher from the URLSession which gives us a publisher to play around with
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { ouput in
                guard ouput.response is HTTPURLResponse else {
                    Logger.log(.error, "Server error")
                    throw NetworkError.serverError(code: 0, error: "Server Error")
                }
                return ouput.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                Logger.log(.error, "json decoding fails ")
                return NetworkError.invalidJSON("invalid JSON")
            }
            .eraseToAnyPublisher()
    }
}

public struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod?
    
    init(url: String,
         headers: [String: String]? = nil,
         reqBody: Encodable? = nil,
         reqTimeOut: Float? = nil,
         httpMethod: HTTPMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody?.encode()
        self.requestTimeOut = reqTimeOut
        self.httpMethod = httpMethod
    }
    
    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod?.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        return urlRequest
    }
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        }
        catch {
            return nil
        }
    }
}
