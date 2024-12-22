//
//  Request.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import Foundation

struct HttpEntity: Codable {
    let etag: String
    let lastModified: String
}

struct Request {
    var httpMethod: String? = "GET"
    var path: String
    var queryParams: [URLQueryItem] = []
    var headers: [String: String] = [:]
    var body: Data?
    var entity: HttpEntity?

    func getUrlRequest() throws -> URLRequest {
        guard let baseUrl = URL(string: path) else {
            throw NetworkServiceError.invalidUrl(urlStr: path)
        }

        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)

        if !queryParams.isEmpty {
            components?.queryItems = queryParams
        }

        guard let url = components?.url else {
            throw NetworkServiceError.invalidUrlComponents(message: "Invalid url components")
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = body

        urlRequest.allHTTPHeaderFields = headers

        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        if let entity {
            urlRequest.addValue(entity.lastModified, forHTTPHeaderField: "If-Modified-Since")
            urlRequest.addValue(entity.etag, forHTTPHeaderField: "If-None-Match")
        }

        return urlRequest
    }
}
