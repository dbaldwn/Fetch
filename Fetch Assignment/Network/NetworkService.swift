//
//  NetworkService.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import Foundation

struct NetworkService {

    static var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = false
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        return URLSession(configuration: configuration)
    }

    static func fetch<T: Decodable>(with request: Request, session: URLSession = session) async throws -> FetchedDataWithEntity<T> {
        let urlRequest = try request.getUrlRequest()
        do {
            let (data, response) = try await session.data(for: urlRequest)
            return try handle(response, with: data)
        } catch let error as NSError where error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                throw NetworkServiceError.unavailableInternetConnection(error)
        } catch let error as NSError where error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
            throw NetworkServiceError.cancelled(error)
        } catch let error where error.isOtherConnectionError == true {
            throw NetworkServiceError.unavailableInternetConnection(error)
        }
    }

    static func handle<T: Decodable>(_ response: URLResponse?, with data: Data?) throws -> FetchedDataWithEntity<T> {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkServiceError.badResponse(message: "Response is not HTTPURLResponse")
        }

        guard response.statusCode != 304 else {
            return .success304
        }

        guard response.statusCode == 200 else {
            throw NetworkServiceError.http(statusCode: response.statusCode)
        }

        guard let data = data, !data.isEmpty else {
            throw NetworkServiceError.badResponse(message: "Data unavailable")
        }

        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            return .success(object)
        } catch let error as DecodingError {
            throw NetworkServiceError.decoding(message: error.localizedDescription)
        } catch {
            throw NetworkServiceError.unknown(error)
        }
    }
}

enum FetchedDataWithEntity<T> {
    case success(T)
    case success304
}

extension Error {

    public var NSURLErrorConnectionFailureCodes: [Int] {
        [
            NSURLErrorBackgroundSessionInUseByAnotherProcess, /// Error Code: `-996`
            NSURLErrorCannotFindHost, /// Error Code: ` -1003`
            NSURLErrorCannotConnectToHost, /// Error Code: ` -1004`
            NSURLErrorNetworkConnectionLost, /// Error Code: ` -1005`
            NSURLErrorNotConnectedToInternet, /// Error Code: ` -1009`
            NSURLErrorSecureConnectionFailed /// Error Code: ` -1200`
        ]
    }
    /// Indicates an error which is caused by various connection related issue or an unaccepted status code.
    var isOtherConnectionError: Bool {
        NSURLErrorConnectionFailureCodes.contains(_code)
    }
}
